use crate::domain::dto::*;
use sqlx::PgPool;

pub async fn create_specification(
    db: &PgPool,
    specification: &Specification,
) -> Result<i32, sqlx::Error> {
    let _result = sqlx::query("insert into specification (name) values ($1)")
        .bind(&specification.name)
        .execute(db)
        .await?;
    Ok(33)
}

pub async fn get_specifications(db: &PgPool) -> Result<Vec<(i32, String)>, sqlx::Error> {
    let rows: Vec<(i32, String)> = sqlx::query_as("select id, name from specification")
        .fetch_all(db)
        .await?;
    Ok(rows)
}
pub async fn give_reward(db: &PgPool, user_id: i32, reward: i32) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into reward_user (reward_id, user_id) values ($1, $2)")
        .bind(reward)
        .bind(user_id)
        .execute(db)
        .await?;
    Ok(())
}

pub async fn create_exercice(db: &PgPool, exercise: &Exercise) -> Result<(), sqlx::Error> {
    let _result = sqlx::query(
        "insert into exercice (name, measurement, exercice_type_id) values ($1, $2, $3)",
    )
    .bind(&exercise.name)
    .bind(&exercise.measurement)
    .bind(exercise.exercice_type_id)
    .execute(db)
    .await?;
    Ok(())
}
pub async fn create_exercice_type(
    db: &PgPool,
    exercise_type: &ExerciceType,
) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into exercice_type (name) values ($1)")
        .bind(&exercise_type.name)
        .execute(db)
        .await?;
    Ok(())
}
pub async fn create_reward(db: &PgPool, reward: &Reward) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into reward (name, condition) values ($1, $2)")
        .bind(&reward.name)
        .bind(&reward.condition)
        .execute(db)
        .await?;
    Ok(())
}
pub async fn give_exercice(
    db: &PgPool,
    user_exercise: &UserExercisePair,
) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into exercice_user (user_id, exercice_id) values ($1, $2)")
        .bind(user_exercise.user_id.unwrap_or(0))
        .bind(user_exercise.exercise_id)
        .execute(db)
        .await?;
    Ok(())
}
