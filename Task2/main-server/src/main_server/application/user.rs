use super::authentication as auth;
use crate::domain::dto::*;
use crate::infrastructure::postgresql::{
    admin_repo, authentication as auth_repo, personal_repo, user_repo,
};

use sqlx::PgPool;

pub async fn create_user(mut db: &PgPool, mut user: User) -> Result<i32, String> {
    let password_hash = auth::hash_password(&user.password.unwrap());
    user.password = Some(password_hash);
    match auth_repo::create_user(&mut db, &user).await {
        Ok(user_id) => Ok(user_id),
        Err(e) => Err(e.to_string()),
    }
}

pub async fn login_user(db: &PgPool, req: User) -> Result<String, String> {
    let user = auth_repo::get_user_with_password(db, &req.email)
        .await
        .unwrap();
    if auth::verify_password(&req.password.unwrap(), &user.1) {
        Ok(auth::create_token(user.0))
    } else {
        Err("User not found".to_string())
    }
}

pub async fn get_user_info(db: &PgPool, token: &str) -> Result<User, String> {
    let user_id = auth::validate_token(token).unwrap();
    let user = user_repo::get_user_info(db, user_id).await;
    match user {
        Ok(user) => Ok(user),
        Err(e) => Err(e.to_string()),
    }
}

pub async fn give_reward(
    mut db: &PgPool,
    token: &str,
    user_reward: &UserRewardPair,
) -> Result<i32, String> {
    let personal_id = auth::validate_token(token)?;
    if !auth_repo::is_personal(&mut db, personal_id).await.unwrap() {
        return Err("User is not personal".to_string());
    }
    personal_repo::give_reward(
        &mut db,
        user_reward.user_id.unwrap_or(personal_id),
        user_reward.reward_id,
    )
    .await
    .unwrap();
    Ok(10)
}

pub async fn create_exercice(
    mut db: &PgPool,
    token: &str,
    exercice: &Exercise,
) -> Result<i32, String> {
    let user_id = auth::validate_token(token)?;
    let user_access_level = admin_repo::get_admin_access_level(&mut db, user_id)
        .await
        .unwrap();
    if user_access_level < 2 {
        return Err("User access level is not enough".to_string());
    }
    personal_repo::create_exercice(&mut db, &exercice)
        .await
        .unwrap();
    Ok(10)
}

pub async fn get_exercices(mut db: &PgPool) -> Vec<(i32, String)> {
    user_repo::get_exercices(&mut db).await.unwrap()
}

pub async fn give_exercice(
    mut db: &PgPool,
    token: &str,
    user_exercise: &mut UserExercisePair,
) -> Result<i32, String> {
    let user_id = auth::validate_token(token)?;
    if let None = user_exercise.user_id {
        user_exercise.user_id = Some(user_id);
    }
    personal_repo::give_exercice(&mut db, &user_exercise)
        .await
        .unwrap();
    Ok(10)
}

pub async fn create_exercise_type(
    mut db: &PgPool,
    token: &str,
    exercise_type: &ExerciceType,
) -> Result<i32, String> {
    let user_id = auth::validate_token(token)?;
    let user_access_level = admin_repo::get_admin_access_level(&mut db, user_id)
        .await
        .unwrap();
    if user_access_level < 8 {
        return Err("User access level is not enough".to_string());
    }
    personal_repo::create_exercice_type(&mut db, &exercise_type)
        .await
        .unwrap();
    Ok(10)
}

pub async fn get_exercises_types(db: &PgPool) -> Vec<(i32, String)> {
    user_repo::get_exercise_types(db).await.unwrap()
}

pub async fn create_reward(db: &PgPool, token: &str, reward: &Reward) -> Result<i32, String> {
    let user_id = auth::validate_token(token)?;
    let user_access_level = admin_repo::get_admin_access_level(db, user_id)
        .await
        .unwrap();
    if user_access_level < 8 {
        return Err("User access level is not enough".to_string());
    }
    personal_repo::create_reward(db, &reward).await.unwrap();
    Ok(10)
}

pub async fn get_user_types(db: &PgPool, user_id: i32) -> Vec<String> {
    let is_personal = auth_repo::is_personal(db, user_id).await.unwrap();
    let is_admin = admin_repo::is_admin(db, user_id).await.unwrap();
    let mut response = Vec::with_capacity(2);
    if is_personal {
        response.push("personal".to_string());
    }
    if is_admin {
        response.push("admin".to_string());
    }
    response
}
