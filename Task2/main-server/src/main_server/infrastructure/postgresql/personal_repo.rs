use super::{sqlx, MutDb};
use crate::domain::dto::*;
pub async fn create_specification(
    mut db: MutDb,
    specification: &Specification,
) -> Result<i32, sqlx::Error> {
    let _result = sqlx::query("insert into specification (name) values ($1)")
        .bind(&specification.name)
        .execute(&mut **db)
        .await?;
    Ok(33)
}

pub async fn get_specifications(mut db: MutDb) -> Result<Vec<(i32, String)>, sqlx::Error> {
    let rows: Vec<(i32, String)> = sqlx::query_as("select id, name from specification")
        .fetch_all(&mut **db)
        .await?;
    Ok(rows)
}
pub async fn give_reward(db: &mut MutDb, user_id: i32, reward: i32) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into reward_user (reward_id, user_id) values ($1, $2)")
        .bind(reward)
        .bind(user_id)
        .execute(&mut ***db)
        .await?;
    Ok(())
}

pub async fn create_exercice(db: &mut MutDb, exercise: &Exercise) -> Result<(), sqlx::Error> {
    let _result = sqlx::query(
        "insert into exercice (name, measurement, exercice_type_id) values ($1, $2, $3)",
    )
    .bind(&exercise.name)
    .bind(&exercise.measurement)
    .bind(exercise.exercice_type_id)
    .execute(&mut ***db)
    .await?;
    Ok(())
}
pub async fn create_exercice_type(
    db: &mut MutDb,
    exercise_type: &ExerciceType,
) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into exercice_type (name) values ($1)")
        .bind(&exercise_type.name)
        .execute(&mut ***db)
        .await?;
    Ok(())
}
pub async fn create_reward(db: &mut MutDb, reward: &Reward) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into reward (name, condition) values ($1, $2)")
        .bind(&reward.name)
        .bind(&reward.condition)
        .execute(&mut ***db)
        .await?;
    Ok(())
}
pub async fn give_exercice(
    db: &mut MutDb,
    user_exercise: &UserExercisePair,
) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into exercice_user (user_id, exercice_id) values ($1, $2)")
        .bind(user_exercise.user_id.unwrap_or(0))
        .bind(user_exercise.exercise_id)
        .execute(&mut ***db)
        .await?;
    Ok(())
}
