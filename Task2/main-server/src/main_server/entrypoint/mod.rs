pub mod authorizations {
    use rocket::serde::json::Json;

    pub mod dto {

        use rocket::serde::{Deserialize, Serialize};

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct LogInDtoRequest {
            pub email: String,
            pub password: String,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct LogInDtoResponse {
            pub token: String,
            pub message: u32,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct LogUpDtoRequest {
            pub email: String,
            pub name: String,
            pub surname: String,
            pub password: String,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct LogUpDtoResponse {
            pub token: String,
            pub message: String,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct UserInfoResponse {
            pub email: String,
            pub name: String,
            pub surname: String,
        }
    }

    pub mod token_provider {
        pub struct ApiKey<'r>(&'r str);

        #[derive(Debug)]
        pub enum ApiKeyError {
            Missing,
            Invalid,
        }

        use rocket::http::Status;
        use rocket::request::{FromRequest, Outcome, Request};

        #[rocket::async_trait]
        impl<'r> FromRequest<'r> for ApiKey<'r> {
            type Error = ApiKeyError;

            async fn from_request(req: &'r Request<'_>) -> Outcome<Self, Self::Error> {
                match req.headers().get_one("Authorization") {
                    None => Outcome::Error((Status::BadRequest, ApiKeyError::Missing)),
                    Some(key) if key.starts_with("Bearer ") => {
                        let key = key.trim_start_matches("Bearer ");
                        Outcome::Success(ApiKey(key))
                    }
                    _ => Outcome::Error((Status::BadRequest, ApiKeyError::Invalid)),
                }
            }
        }

        impl<'r> From<ApiKey<'r>> for &'r str {
            fn from(api_key: ApiKey<'r>) -> &'r str {
                api_key.0
            }
        }
    }

    use crate::application::use_cases;
    use crate::infrastructure::postgresql::{create_user, DataBaseWraper, MutDb, UserDTO};

    #[post("/log_up", format = "json", data = "<log_up>")]
    pub async fn log_up(
        mut db: MutDb,
        log_up: Json<dto::LogUpDtoRequest>,
    ) -> Json<dto::LogUpDtoResponse> {
        println!("Creating user: {}", log_up.email);
        let user_create_request = use_cases::UserCreateRequest::new(
            log_up.name.clone(),
            log_up.surname.clone(),
            log_up.email.clone(),
            log_up.password.clone(),
        );
        let user_id = use_cases::create_user(db, user_create_request).await;

        Json::from(dto::LogUpDtoResponse {
            token: use_cases::authorizations::create_token(user_id),
            message: "User created".to_string(),
        })
    }

    #[post("/log_in", format = "json", data = "<log_in>")]
    pub async fn log_in(
        db: &DataBaseWraper,
        log_in: Json<dto::LogInDtoRequest>,
    ) -> Json<dto::LogInDtoResponse> {
        println!("Loging in user: {}", log_in.email);
        let result = use_cases::login_user(
            db,
            use_cases::UserLoginRequest::new(log_in.email.clone(), log_in.password.clone()),
        )
        .await;
        match result {
            Ok(token) => Json::from(dto::LogInDtoResponse {
                token,
                message: 200,
            }),
            Err(err) => Json::from(dto::LogInDtoResponse {
                token: err,
                message: 404,
            }),
        }
    }

    #[get("/user_info")]
    pub async fn user_info(
        db: &DataBaseWraper,
        api_key: token_provider::ApiKey<'_>,
    ) -> Json<dto::UserInfoResponse> {
        let user = use_cases::get_user_info(db, api_key.into()).await;
        Json::from(dto::UserInfoResponse {
            email: user.email,
            name: user.name,
            surname: user.surname,
        })
    }

    pub fn get_routes() -> Vec<rocket::Route> {
        routes![log_up, log_in, user_info]
    }
}

pub mod personal {
    pub mod dto {
        use rocket::serde::{Deserialize, Serialize};

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct PersonalCreateRequest {
            pub user_id: i64,
            pub specification_id: i64,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct PersonalCreateResponse {
            pub message: String,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct SpecificationListResponse {
            pub specifications: Vec<(i64, String)>,
        }
        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct SpecificationCreateRequest {
            pub name: String,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct SpecificationCreateResponse {
            pub message: String,
        }
    }

    pub mod endpoints {
        use crate::application::use_cases;
        use crate::entrypoint::authorizations::token_provider::ApiKey;
        use crate::infrastructure::postgresql::MutDb;
        use rocket::serde::json::Json;

        #[post("/create_personal", format = "json", data = "<personal>")]
        pub async fn create_personal(
            mut db: MutDb,
            personal: Json<super::dto::PersonalCreateRequest>,
            token: ApiKey<'_>,
        ) -> Json<super::dto::PersonalCreateResponse> {
            println!("Creating personal: {}", personal.user_id);
            let result = use_cases::create_personal(
                db,
                token.into(),
                use_cases::PersonalCreateRequest {
                    user_id: personal.user_id,
                    specification_id: personal.specification_id,
                },
            )
            .await;
            Json::from(super::dto::PersonalCreateResponse {
                message: match result {
                    Ok(_) => "Personal created".to_string(),
                    Err(err) => err,
                },
            })
        }
        #[post("/create_specification", format = "json", data = "<specification>")]
        pub async fn create_specification(
            mut db: MutDb,
            specification: Json<super::dto::SpecificationCreateRequest>,
            token: ApiKey<'_>,
        ) -> Json<super::dto::SpecificationCreateResponse> {
            println!("Creating specification: {}", specification.name);
            let result =
                use_cases::create_specification(db, token.into(), specification.name.clone()).await;

            Json::from(super::dto::SpecificationCreateResponse {
                message: match result {
                    Ok(_) => "Specification created".to_string(),
                    Err(err) => err,
                },
            })
        }

        #[get("/specifications")]
        pub async fn get_specifications(
            mut db: MutDb,
        ) -> Json<super::dto::SpecificationListResponse> {
            let specifications = use_cases::get_specifications(db).await;
            Json::from(super::dto::SpecificationListResponse { specifications })
        }
    }

    use endpoints::{create_personal, create_specification};
    pub fn get_routes() -> Vec<rocket::Route> {
        routes![create_personal, create_specification]
    }
}

pub mod admin {
    pub mod dto {
        use rocket::serde::{Deserialize, Serialize};

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct AdminCreateRequest {
            pub user_id: i64,
            pub access_level: i8,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct AdminCreateResponse {
            pub message: String,
        }
    }

    pub mod endpoints {
        use crate::application::use_cases;
        use crate::entrypoint::authorizations::token_provider::ApiKey;
        use crate::infrastructure::postgresql::MutDb;
        use rocket::serde::json::Json;

        #[post("/create_admin", format = "json", data = "<admin>")]
        pub async fn create_admin(
            mut db: MutDb,
            admin: Json<super::dto::AdminCreateRequest>,
            api_key: ApiKey<'_>,
        ) -> Json<super::dto::AdminCreateResponse> {
            println!("Creating admin: {}", admin.user_id);
            let result = use_cases::create_admin(
                db,
                api_key.into(),
                use_cases::AdminCreateRequest {
                    id: admin.user_id,
                    access_level: admin.access_level,
                },
            )
            .await;
            match result {
                Ok(_) => Json::from(super::dto::AdminCreateResponse {
                    message: "Admin created".to_string(),
                }),
                Err(err) => Json::from(super::dto::AdminCreateResponse { message: err }),
            }
        }
    }

    use endpoints::create_admin;
    pub fn get_routes() -> Vec<rocket::Route> {
        routes![create_admin]
    }
}

pub mod user {
    pub mod dto {
        use rocket::serde::{Deserialize, Serialize};

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct RewardGiveRequest {
            pub user_id: i64,
            pub reward_id: i64,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct RewardGiveResponse {
            pub message: String,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct CreateExerciceRequest {
            pub name: String,
            pub measurement: String,
            pub exercice_type_id: i64,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct CreateExerciceResponse {
            pub message: String,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct ExerciceListResponse {
            pub exercices: Vec<(i64, String)>,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct ExerciceGiveRequest {
            pub user_id: i64,
            pub exercice_id: i64,
        }
    }
    pub mod endpoints {
        use crate::application::use_cases;
        use crate::entrypoint::authorizations::token_provider::ApiKey;
        use crate::infrastructure::postgresql::MutDb;
        use rocket::serde::json::Json;

        #[post("/give_reward", format = "json", data = "<reward>")]
        pub async fn give_reward(
            mut db: MutDb,
            reward: Json<super::dto::RewardGiveRequest>,
            api_key: ApiKey<'_>,
        ) -> Json<super::dto::RewardGiveResponse> {
            println!("Giving reward: {}", reward.user_id);
            let result =
                use_cases::give_reward(db, api_key.into(), reward.user_id, reward.reward_id).await;
            Json::from(super::dto::RewardGiveResponse {
                message: match result {
                    Ok(_) => "Reward given".to_string(),
                    Err(err) => err,
                },
            })
        }

        #[post("/create_exercice", format = "json", data = "<exercice>")]
        pub async fn create_exercice(
            mut db: MutDb,
            exercice: Json<super::dto::CreateExerciceRequest>,
            api_key: ApiKey<'_>,
        ) -> Json<super::dto::CreateExerciceResponse> {
            println!("Creating exercice: {}", exercice.name);
            let result = use_cases::create_exercice(
                db,
                api_key.into(),
                use_cases::ExerciceCreateRequest {
                    name: exercice.name.clone(),
                    measurement: exercice.measurement.clone(),
                    exercice_type_id: exercice.exercice_type_id,
                },
            )
            .await;
            Json::from(super::dto::CreateExerciceResponse {
                message: match result {
                    Ok(_) => "Exercice created".to_string(),
                    Err(err) => err,
                },
            })
        }

        #[get("/exercices")]
        pub async fn get_exercices(mut db: MutDb) -> Json<super::dto::ExerciceListResponse> {
            let exercices = use_cases::get_exercices(db).await;
            Json::from(super::dto::ExerciceListResponse { exercices })
        }

        #[post("/give_exercice", format = "json", data = "<exercice>")]
        pub async fn give_exercice(
            mut db: MutDb,
            exercice: Json<super::dto::ExerciceGiveRequest>,
            api_key: ApiKey<'_>,
        ) -> Json<super::dto::RewardGiveResponse> {
            println!("Giving exercice: {}", exercice.user_id);
            let result = use_cases::give_exercice(
                db,
                api_key.into(),
                exercice.user_id,
                exercice.exercice_id,
            )
            .await;
            Json::from(super::dto::RewardGiveResponse {
                message: match result {
                    Ok(_) => "Exercice given".to_string(),
                    Err(err) => err,
                },
            })
        }
    }

    pub fn get_routes() -> Vec<rocket::Route> {
        routes![
            endpoints::give_reward,
            endpoints::create_exercice,
            endpoints::get_exercices,
            endpoints::give_exercice
        ]
    }
}
