use rocket::serde::json::Json;

pub mod jwt_provider {
    pub struct ApiKey<'r>(&'r str);

    // Middleware, що дістає ключа з заголовка Authorization
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

use crate::domain::dto::*;
use rocket::State;
use sqlx::PgPool;

use crate::application::{authentication as auth, user as use_cases};

#[post("/log_up", format = "json", data = "<user>")]
pub async fn log_up(db: &State<PgPool>, user: Json<User>) -> Json<String> {
    println!("Creating user: {}", user.email);
    let user_id = use_cases::create_user(db, user.0).await.unwrap();
    Json::from(auth::create_token(user_id))
}

#[post("/log_in", format = "json", data = "<user>")]
pub async fn log_in(db: &State<PgPool>, user: Json<User>) -> Json<String> {
    println!("Loging in user: {}", user.email);
    let user_token = use_cases::login_user(db, user.0).await.unwrap();
    return Json::from(user_token);
}

#[get("/user_info")]
pub async fn user_info(db: &State<PgPool>, api_key: jwt_provider::ApiKey<'_>) -> Json<User> {
    let user = use_cases::get_user_info(db, api_key.into()).await.unwrap();
    Json::from(user)
}

#[get("/user_types")]
pub async fn get_user_types(
    db: &State<PgPool>,
    api_key: jwt_provider::ApiKey<'_>,
) -> Json<Vec<String>> {
    let user_id = auth::validate_token(api_key.into()).unwrap();
    Json::from(use_cases::get_user_types(db, user_id).await)
}

pub fn get_routes() -> Vec<rocket::Route> {
    routes![log_up, log_in, user_info, get_user_types]
}
