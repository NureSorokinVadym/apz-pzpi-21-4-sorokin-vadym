use crate::domain::dto::*;
use sqlx::types::time::PrimitiveDateTime;
use sqlx::PgPool;
use sqlx::Row;
use std::collections::HashMap;

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

pub async fn get_specifications(db: &PgPool) -> Result<HashMap<i32, String>, sqlx::Error> {
    let rows: Vec<(i32, String)> = sqlx::query_as("select id, name from specification")
        .fetch_all(db)
        .await?;
    Ok(rows.into_iter().collect())
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
) -> Result<i32, sqlx::Error> {
    let id: Option<(i32,)> = sqlx::query_as("select id from exercice_type where name = $1")
        .bind(&exercise_type.name)
        .fetch_optional(db)
        .await?;
    if id.is_some() {
        return Ok(id.unwrap().0);
    }

    let id: (i32,) = sqlx::query_as("insert into exercice_type (name) values ($1) returning id")
        .bind(&exercise_type.name)
        .fetch_one(db)
        .await?;
    Ok(id.0)
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
) -> Result<i32, sqlx::Error> {
    let id: (i32,) = sqlx::query_as(
        "insert into exercice_user (user_id, exercice_id) values ($1, $2) returning id",
    )
    .bind(user_exercise.user_id.unwrap_or(0))
    .bind(user_exercise.exercise_id)
    .fetch_one(db)
    .await?;
    Ok(id.0)
}

pub async fn get_client_from_personal(
    db: &PgPool,
    _personal_id: i32,
) -> Result<Vec<User>, sqlx::Error> {
    let clients: Vec<(i32, String, Option<String>, String)> =
        sqlx::query_as("select id, name, surname, email from user_base")
            .fetch_all(db)
            .await?;

    Ok(clients.iter().map(User::from).collect())
}

pub async fn get_client_exercises(
    db: &PgPool,
    user_id: i32,
) -> Result<Vec<ExerciseUser>, sqlx::Error> {
    let exercises = sqlx::query(
        "select exercice_user.id as ex_us_id, exercice_user.duration, exercice_user.weight, exercice_user.number, exercice_user.pulse,
        exercice_user.create_at as ex_us_create_at, exercice.id as ex_id, exercice.name, exercice.measurement, exercice.exercice_type_id, exercice.create_at as ex_create_at from exercice_user
        join exercice on exercice_user.exercice_id = exercice.id
        where exercice_user.user_id = $1",
    )
    .bind(user_id)
    .fetch_all(db)
    .await?;

    Ok(exercises
        .iter()
        .map(|e| {
            let ex_us_ct: PrimitiveDateTime = e.get("ex_us_create_at");
            let ex_ct: PrimitiveDateTime = e.get("ex_create_at");
            ExerciseUser {
                id: e.get("ex_us_id"),
                duration: e.get("duration"),
                weight: e.get("weight"),
                number: e.get("number"),
                pulse: e.get("pulse"),
                create_at: ex_us_ct.to_string(),
                exercise: Exercise {
                    id: e.get("ex_id"),
                    name: e.get("name"),
                    measurement: e.get("measurement"),
                    exercice_type_id: e.get("exercice_type_id"),
                    create_at: Some(ex_ct.to_string()),
                },
            }
        })
        .collect())
}

pub async fn get_exercises_list(db: &PgPool) -> Result<Vec<Exercise>, sqlx::Error> {
    let exercises: Vec<(i32, String, String, i32, PrimitiveDateTime)> =
        sqlx::query_as("select id, name, measurement, exercice_type_id, create_at from exercice")
            .fetch_all(db)
            .await?;
    Ok(exercises
        .iter()
        .map(|e| Exercise {
            id: Some(e.0),
            name: e.1.clone(),
            measurement: e.2.clone(),
            exercice_type_id: e.3,
            create_at: Some(e.4.to_string()),
        })
        .collect())
}

pub async fn add_exercise(db: &PgPool, pair: &UserExercisePair) -> Result<(), sqlx::Error> {
    let result = sqlx::query("insert into exercice_user (user_id, exercice_id) values ($1, $2)")
        .bind(pair.user_id.unwrap_or(1))
        .bind(pair.exercise_id)
        .execute(db)
        .await;
    print!("{:?}", result);

    Ok(())
}

pub async fn get_exercise_types(db: &PgPool) -> Result<HashMap<i32, String>, sqlx::Error> {
    let types: Vec<(i32, String)> = sqlx::query_as("select id, name from exercice_type")
        .fetch_all(db)
        .await?;
    Ok(types.into_iter().collect())
}

pub async fn set_exercise_task(
    db: &PgPool,
    user_id: i32,
    exercise_user_id: i32,
) -> Result<(), sqlx::Error> {
    sqlx::query("update iot_user set next_exercise_id = $1 where user_id = $2")
        .bind(exercise_user_id)
        .bind(user_id)
        .execute(db)
        .await?;
    Ok(())
}
