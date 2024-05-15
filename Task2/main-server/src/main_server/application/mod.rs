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

        pub fn create_token(user_id: u32) -> String {
            let mut claims = BTreeMap::new();
            claims.insert("user_id", user_id.to_string());
            claims.sign_with_key(&get_key()).unwrap()
        }

        fn validate_token(token: &str) -> Result<u32, String> {
            let claims: BTreeMap<String, String> = token.verify_with_key(&get_key()).unwrap();
            let user_id = claims.get("user_id").ok_or("User id not found")?;
            Ok(user_id.parse().map_err(|_| "User id is not a number")?)
        }
    }

    pub async fn create_user(db: postgresql::MutDb, name: &str) {
        postgresql::create_user(db, name).await.unwrap();
    }

    pub async fn get_user(db: &postgresql::DataBaseWraper, email: &str) {
        postgresql::get_user(db, email).await.unwrap();
    }

    pub async fn get_token(
        mut db: &postgresql::DataBaseWraper,
        user_email: &str,
        password: &str,
    ) -> Result<String, String> {
        if !user_email.is_empty() && password == "password" {
            let user = postgresql::get_user_id(&db, user_email).await.unwrap();
            Ok(authorizations::create_token(user))
        } else {
            Err("User not found".to_string())
        }
    }
}
