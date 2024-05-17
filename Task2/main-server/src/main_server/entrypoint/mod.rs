pub mod admin;
pub mod authentication;
pub mod personal;
pub mod user;

use authentication::jwt_provider::ApiKey;
use rocket::serde::json::Json;
