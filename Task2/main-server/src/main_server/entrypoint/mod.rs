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
