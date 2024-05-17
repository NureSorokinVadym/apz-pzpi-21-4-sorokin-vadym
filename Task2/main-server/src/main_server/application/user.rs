use super::authentication as auth;
use crate::domain::dto::*;
use crate::infrastructure::postgresql;

use postgresql::DataBaseWraper;

pub async fn create_user(mut db: postgresql::MutDb, user: User) -> Result<i32, String> {
    let password_hash = auth::hash_password(&user.password.unwrap());
    let pg_user =
        postgresql::UserDTO::new(user.email, user.name, user.surname.unwrap(), password_hash);
    match postgresql::create_user(&mut db, pg_user).await {
        Ok(user_id) => Ok(user_id),
        Err(e) => Err(e.to_string()),
    }
}

pub async fn login_user(db: &postgresql::DataBaseWraper, req: User) -> Result<String, String> {
    let user = postgresql::get_user_with_password(db, &req.email)
        .await
        .unwrap();
    if auth::verify_password(&req.password.unwrap(), &user.1) {
        Ok(auth::create_token(user.0))
    } else {
        Err("User not found".to_string())
    }
}

pub async fn get_user_info(db: &DataBaseWraper, token: &str) -> Result<User, String> {
    let user_id = auth::validate_token(token).unwrap();
    let user = postgresql::get_user_info(db, user_id).await;
    match user {
        Ok(user) => Ok(User::new_basic(user.email, user.name, user.surname)),
        Err(e) => Err(e.to_string()),
    }
}

pub async fn give_reward(
    mut db: postgresql::MutDb,
    token: &str,
    user_reward: &UserRewardPair,
) -> Result<i32, String> {
    let personal_id = auth::validate_token(token)?;
    if !postgresql::is_personal(&mut db, personal_id).await {
        return Err("User is not personal".to_string());
    }
    postgresql::give_reward(
        &mut db,
        user_reward.user_id.unwrap_or(personal_id),
        user_reward.reward_id,
    )
    .await
    .unwrap();
    Ok(10)
}

pub async fn create_exercice(
    mut db: postgresql::MutDb,
    token: &str,
    exercice: &Exercise,
) -> Result<i32, String> {
    let user_id = auth::validate_token(token)?;
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
    Ok(10)
}

pub async fn get_exercices(mut db: postgresql::MutDb) -> Vec<(i32, String)> {
    postgresql::get_exercices(&mut db).await.unwrap()
}

pub async fn give_exercice(
    mut db: postgresql::MutDb,
    token: &str,
    user_exercise: &UserExercisePair,
) -> Result<i32, String> {
    let user_id = auth::validate_token(token)?;
    postgresql::give_exercice(
        &mut db,
        user_exercise.user_id.unwrap_or(user_id),
        user_exercise.exercise_id,
    )
    .await
    .unwrap();
    Ok(10)
}

pub async fn create_exercise_type(
    mut db: postgresql::MutDb,
    token: &str,
    exercise_type: &ExerciceType,
) -> Result<i32, String> {
    let user_id = auth::validate_token(token)?;
    let user_access_level = postgresql::get_admin_access_level(&mut db, user_id)
        .await
        .unwrap();
    if user_access_level < 8 {
        return Err("User access level is not enough".to_string());
    }
    postgresql::create_exercice_type(&mut db, &exercise_type.name)
        .await
        .unwrap();
    Ok(10)
}

pub async fn create_reward(
    mut db: postgresql::MutDb,
    token: &str,
    reward: &Reward,
) -> Result<i32, String> {
    let user_id = auth::validate_token(token)?;
    let user_access_level = postgresql::get_admin_access_level(&mut db, user_id)
        .await
        .unwrap();
    if user_access_level < 8 {
        return Err("User access level is not enough".to_string());
    }
    postgresql::create_reward(&mut db, &reward.name, &reward.condition)
        .await
        .unwrap();
    Ok(10)
}
