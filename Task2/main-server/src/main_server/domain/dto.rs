use rocket::serde::{Deserialize, Serialize};
use sqlx::FromRow;

// Структура для відповіді на запити з сервера
#[derive(Serialize, Deserialize, Debug)]
#[serde(rename_all = "camelCase", crate = "rocket::serde")]
pub struct DefaultResponse {
    pub id: Option<i32>,
    pub message: String,
}
impl DefaultResponse {
    pub fn new(message: String) -> Self {
        DefaultResponse { id: None, message }
    }

    pub fn new_with_id(id: i32, message: String) -> Self {
        DefaultResponse {
            id: Some(id),
            message,
        }
    }
}

// Імплементація для перетворення з Result<i32, String> віпдовіді СУБД в DefaultResponse
impl From<Result<i32, String>> for DefaultResponse {
    fn from(result: Result<i32, String>) -> Self {
        match result {
            Ok(id) => DefaultResponse::new_with_id(id, "Success".to_string()),
            Err(message) => DefaultResponse::new(message),
        }
    }
}

#[derive(Serialize, Deserialize, Debug)]
#[serde(crate = "rocket::serde")]
pub struct Id {
    pub id: i32,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct UserRewardPair {
    pub user_id: Option<i32>,
    pub reward_id: i32,
}
#[derive(Debug, Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct UserExercisePair {
    pub user_id: Option<i32>,
    pub exercise_id: i32,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct UserIotPair {
    pub user_id: Option<i32>,
    pub iot_id: i32,
    pub next_exercise_id: Option<i32>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct ExerciseUser {
    pub id: Option<i32>,
    pub exercise: Exercise,
    pub duration: Option<i32>,
    pub number: Option<i32>,
    pub weight: Option<i32>,
    pub pulse: Option<i32>,
    #[serde(rename = "date")]
    pub create_at: String,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(crate = "rocket::serde")]
pub struct Exercise {
    pub id: Option<i32>,
    pub name: String,
    pub measurement: String,
    #[serde(rename = "exerciseTypeId")]
    pub exercice_type_id: i32,
    #[serde(rename = "date")]
    pub create_at: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct ExerciceType {
    pub id: Option<i32>,
    pub name: String,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct Reward {
    pub id: Option<i32>,
    pub name: String,
    pub condition: String,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct Admin {
    pub id: Option<i32>,
    pub user_id: i32,
    pub access_level: i32,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct Personal {
    pub id: Option<i32>,
    pub user_id: i32,
    pub specification_id: i32,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct Specification {
    pub id: Option<i32>,
    pub name: String,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct User {
    pub id: Option<i32>,
    pub name: Option<String>,
    pub surname: Option<String>,
    pub email: String,
    pub password: Option<String>,
}

impl User {
    pub fn new_basic(email: String, name: String, surname: String) -> Self {
        User {
            id: None,
            name: Some(name),
            surname: Some(surname),
            email,
            password: None,
        }
    }
}

impl From<&(i32, String, Option<String>, String)> for User {
    fn from(user: &(i32, String, Option<String>, String)) -> Self {
        User {
            id: Some(user.0),
            name: Some(user.1.to_owned()),
            surname: user.2.to_owned(),
            email: user.3.to_owned(),
            password: None,
        }
    }
}
