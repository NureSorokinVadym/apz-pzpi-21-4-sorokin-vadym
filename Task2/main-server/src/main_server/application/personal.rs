use super::authentication as auth;
use crate::domain::dto::*;
use crate::infrastructure::postgresql::{admin_repo, authentication as auth_repo, personal_repo};

use std::collections::HashMap;

use sqlx::PgPool;

pub async fn create_personal(db: &PgPool, personal: &Personal) -> Result<i32, String> {
    auth_repo::create_personal(db, personal.user_id, personal.specification_id)
        .await
        .unwrap();
    Ok(10)
}

pub async fn get_specifications(db: &PgPool) -> HashMap<i32, String> {
    personal_repo::get_specifications(db).await.unwrap()
}

pub async fn create_specification(
    db: &PgPool,
    token: &str,
    specification: &Specification,
) -> Result<i32, String> {
    let user_id = auth::validate_token(token)?;
    let user_access_level = admin_repo::get_admin_access_level(db, user_id).await;
    if user_access_level.unwrap_or(0) < 5 {
        return Err("User access level is not enough".to_string());
    }
    personal_repo::create_specification(db, &specification)
        .await
        .unwrap();
    Ok(10)
}

pub async fn get_clients(db: &PgPool, token: &str) -> Vec<User> {
    let user_id = auth::validate_token(token).unwrap();

    personal_repo::get_client_from_personal(db, user_id)
        .await
        .unwrap()
}

pub async fn get_client_exercises(db: &PgPool, token: &str, user_id: i32) -> Vec<ExerciseUser> {
    let personal_user_id = auth::validate_token(token).unwrap();
    let is_personal = auth_repo::is_personal(db, personal_user_id).await.unwrap();
    if !is_personal {
        return vec![];
    }
    personal_repo::get_client_exercises(db, user_id)
        .await
        .unwrap()
}

pub async fn get_exercises_list(db: &PgPool) -> Vec<Exercise> {
    personal_repo::get_exercises_list(db).await.unwrap()
}

pub async fn add_exercise(db: &PgPool, token: &str, pair: &UserExercisePair) -> Result<(), String> {
    let personal_user_id = auth::validate_token(token).unwrap();
    let is_personal = auth_repo::is_personal(db, personal_user_id).await.unwrap();
    if !is_personal {
        return Err("User is not personal".to_string());
    }
    personal_repo::add_exercise(db, pair).await.unwrap();
    Ok(())
}

pub async fn get_exercise_types(db: &PgPool) -> HashMap<i32, String> {
    personal_repo::get_exercise_types(db).await.unwrap()
}
