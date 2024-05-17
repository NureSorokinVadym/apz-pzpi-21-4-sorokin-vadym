use rocket::serde::json::Json;

pub mod jwt_provider {
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
use crate::domain::dto::*;
use crate::infrastructure::postgresql::{DataBaseWraper, MutDb};

#[post("/log_up", format = "json", data = "<log_up>")]
pub async fn log_up(db: MutDb, log_up: Json<User>) -> Json<String> {
    println!("Creating user: {}", log_up.email);

    //    let user_create_request = use_cases::UserCreateRequest::new(
    //        log_up.email.clone(),
    //        log_up.password.unwrap().clone(),
    //        log_up.name.clone(),
    //        log_up.surname.unwrap().clone(),
    //    );
    //let user_id = use_cases::create_user(db, user_create_request).await;
    todo!("Implement creating user");
    let user_id = 0;
    Json::from(use_cases::authorizations::create_token(user_id))
}

#[post("/log_in", format = "json", data = "<log_in>")]
pub async fn log_in(db: &DataBaseWraper, log_in: Json<User>) -> Json<String> {
    println!("Loging in user: {}", log_in.email);
    //    let result = use_cases::login_user(
    //        db,
    //        use_cases::UserLoginRequest::new(log_in.email.clone(), log_in.password.clone()),
    //    )
    //    .await;
    todo!("Implement login user");
    Json::from(String::from("awesome token"))
}

#[get("/user_info")]
pub async fn user_info(db: &DataBaseWraper, api_key: jwt_provider::ApiKey<'_>) -> Json<User> {
    let user = use_cases::get_user_info(db, api_key.into()).await;
    Json::from(User::new_basic(user.email, user.name, user.surname))
}

pub fn get_routes() -> Vec<rocket::Route> {
    routes![log_up, log_in, user_info]
}
