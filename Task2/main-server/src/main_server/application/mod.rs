pub mod use_cases {

    use crate::infrastructure::postgresql;

    pub mod authorizations {
        use hmac::{Hmac, Mac};
        use jwt::{SignWithKey, VerifyWithKey};
        use sha2::Sha256;
        use std::collections::BTreeMap;

        const SECRET: &[u8; 10] = b"secret_key";

        fn get_key() -> Hmac<Sha256> {
            Hmac::new_from_slice(SECRET).expect("HMAC can take key of any size")
        }

        pub fn create_token(user_id: i32) -> String {
            let mut claims = BTreeMap::new();
            claims.insert("user_id", user_id.to_string());
            claims.sign_with_key(&get_key()).unwrap()
        }

        pub fn validate_token(token: &str) -> Result<i32, String> {
            let claims: BTreeMap<String, String> = token.verify_with_key(&get_key()).unwrap();
            let user_id = claims.get("user_id").ok_or("User id not found")?;
            Ok(user_id.parse().map_err(|_| "User id is not a number")?)
        }
    }

    pub struct UserCreateRequest {
        name: String,
        surname: String,
        email: String,
        password: String,
    }

    impl UserCreateRequest {
        pub fn new(name: String, surname: String, email: String, password: String) -> Self {
            Self {
                name,
                surname,
                email,
                password,
            }
        }
    }

    use postgresql::DataBaseWraper;
    use pwhash::bcrypt;

    pub async fn create_user(mut db: postgresql::MutDb, user: UserCreateRequest) -> i32 {
        let password_hash = bcrypt::hash(user.password).expect("Password hash error");
        let pg_user = postgresql::UserDTO::new(user.email, user.name, user.surname, password_hash);
        postgresql::create_user(&mut db, pg_user).await.unwrap()
    }

    pub struct UserLoginRequest {
        email: String,
        password: String,
    }

    impl UserLoginRequest {
        pub fn new(email: String, password: String) -> Self {
            Self { email, password }
        }
    }

    pub async fn login_user(
        db: &postgresql::DataBaseWraper,
        req: UserLoginRequest,
    ) -> Result<String, String> {
        let user = postgresql::get_user_with_password(db, &req.email)
            .await
            .unwrap();
        println!("Encripted Password: {}", user.1);
        println!("Password: {}", bcrypt::hash(&req.password).unwrap());
        if bcrypt::verify(req.password, &user.1) {
            println!("User logged in");
            return Ok(authorizations::create_token(user.0));
        } else {
            println!("User not found");
            return Err("User not found".to_string());
        }
    }

    pub struct UserInfo {
        pub name: String,
        pub surname: String,
        pub email: String,
    }

    pub async fn get_user_info(db: &DataBaseWraper, token: &str) -> UserInfo {
        let user_id = authorizations::validate_token(token).unwrap();
        let user = postgresql::get_user_info(db, user_id).await.unwrap();
        UserInfo {
            email: user.email,
            name: user.name,
            surname: user.surname,
        }
    }

    pub struct AdminCreateRequest {
        pub id: i32,
        pub access_level: i32,
    }

    pub async fn create_admin(
        mut db: postgresql::MutDb,
        token: &str,
        admin: AdminCreateRequest,
    ) -> Result<(), String> {
        let user_id = crate::application::use_cases::authorizations::validate_token(token)?;
        let user_access_level = postgresql::get_admin_access_level(&mut db, user_id).await;
        if admin.access_level > user_access_level.unwrap_or(10) {
            return Err("User access level is not enough".to_string());
        }
        postgresql::create_admin(db, admin.id, admin.access_level as i32)
            .await
            .unwrap();
        Ok(())
    }

    pub struct PersonalCreateRequest {
        pub user_id: i32,
        pub specification_id: i32,
    }

    pub async fn create_personal(
        db: postgresql::MutDb,
        personal: PersonalCreateRequest,
    ) -> Result<(), String> {
        postgresql::create_personal(db, personal.user_id, personal.specification_id)
            .await
            .unwrap();
        Ok(())
    }

    pub async fn create_specification(
        mut db: postgresql::MutDb,
        token: &str,
        name: String,
    ) -> Result<(), String> {
        let user_id = crate::application::use_cases::authorizations::validate_token(token)?;
        let user_access_level = postgresql::get_admin_access_level(&mut db, user_id).await;
        if let Err(err) = &user_access_level {
            println!("Error: {}", err);
        }
        if user_access_level.unwrap_or(0) < 5 {
            return Err("User access level is not enough".to_string());
        }
        postgresql::create_specification(db, &name).await.unwrap();
        Ok(())
    }

    pub async fn get_specifications(db: postgresql::MutDb) -> Vec<(i32, String)> {
        postgresql::get_specifications(db).await.unwrap()
    }

    pub async fn give_reward(
        mut db: postgresql::MutDb,
        token: &str,
        user_id: i32,
        reward: i32,
    ) -> Result<(), String> {
        let personal_id = crate::application::use_cases::authorizations::validate_token(token)?;
        if !postgresql::is_personal(&mut db, personal_id).await {
            return Err("User is not personal".to_string());
        }
        postgresql::give_reward(&mut db, user_id, reward)
            .await
            .unwrap();
        Ok(())
    }

    pub struct ExerciceCreateRequest {
        pub name: String,
        pub measurement: String,
        pub exercice_type_id: i32,
    }

    pub async fn create_exercice(
        mut db: postgresql::MutDb,
        token: &str,
        exercice: ExerciceCreateRequest,
    ) -> Result<(), String> {
        let user_id = crate::application::use_cases::authorizations::validate_token(token)?;
        let user_access_level = postgresql::get_admin_access_level(&mut db, user_id)
            .await
            .unwrap();
        if user_access_level < 2 {
            return Err("User access level is not enough".to_string());
        }
        postgresql::create_exercice(
            &mut db,
            &exercice.name,
            &exercice.measurement,
            exercice.exercice_type_id,
        )
        .await
        .unwrap();
        Ok(())
    }

    pub async fn get_exercices(mut db: postgresql::MutDb) -> Vec<(i32, String)> {
        postgresql::get_exercices(&mut db).await.unwrap()
    }

    pub async fn give_exercice(
        mut db: postgresql::MutDb,
        user_id: i32,
        exercice_id: i32,
    ) -> Result<(), String> {
        postgresql::give_exercice(&mut db, user_id, exercice_id)
            .await
            .unwrap();
        Ok(())
    }

    pub async fn create_exercice_type(
        mut db: postgresql::MutDb,
        token: &str,
        name: String,
    ) -> Result<(), String> {
        let user_id = crate::application::use_cases::authorizations::validate_token(token)?;
        let user_access_level = postgresql::get_admin_access_level(&mut db, user_id)
            .await
            .unwrap();
        if user_access_level < 8 {
            return Err("User access level is not enough".to_string());
        }
        postgresql::create_exercice_type(&mut db, &name)
            .await
            .unwrap();
        Ok(())
    }

    pub async fn create_reward(
        mut db: postgresql::MutDb,
        token: &str,
        name: String,
        condition: String,
    ) -> Result<(), String> {
        let user_id = crate::application::use_cases::authorizations::validate_token(token)?;
        let user_access_level = postgresql::get_admin_access_level(&mut db, user_id)
            .await
            .unwrap();
        if user_access_level < 8 {
            return Err("User access level is not enough".to_string());
        }
        postgresql::create_reward(&mut db, &name, &condition)
            .await
            .unwrap();
        Ok(())
    }
}
