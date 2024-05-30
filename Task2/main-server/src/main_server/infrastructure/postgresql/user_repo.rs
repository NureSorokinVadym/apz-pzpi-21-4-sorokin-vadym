use crate::domain::dto::*;

use sqlx::PgPool;

pub async fn get_user_info(db: &PgPool, user_id: i32) -> Result<User, sqlx::Error> {
    let row: (String, String, Option<String>) =
        sqlx::query_as("select email, name, surname from user_base where id = $1")
            .bind(user_id)
            .fetch_one(db)
            .await?;
    Ok(User::new_basic(
        row.0,
        row.1,
        row.2.unwrap_or("".to_string()),
    ))
}
pub async fn get_exercices(db: &PgPool) -> Result<Vec<(i32, String)>, sqlx::Error> {
    let rows: Vec<(i32, String)> = sqlx::query_as("select id, name from exercice")
        .fetch_all(db)
        .await?;
    Ok(rows)
}

pub async fn get_exercise_types(db: &PgPool) -> Result<Vec<(i32, String)>, sqlx::Error> {
    let rows: Vec<(i32, String)> = sqlx::query_as("select id, name from exercice_type")
        .fetch_all(db)
        .await?;
    Ok(rows)
}

pub async fn iot_is_present(db: &PgPool, iot_id: i32) -> Result<bool, sqlx::Error> {
    let row: (i64,) = sqlx::query_as("select count(*) from iot_user where id = $1")
        .bind(iot_id)
        .fetch_one(db)
        .await?;

    Ok(row.0 > 0)
}
pub async fn iot_is_free(db: &PgPool, iot_id: i32) -> Result<bool, sqlx::Error> {
    let row: (i64,) =
        sqlx::query_as("select count(*) from iot_user where id = $1 and user_id is null")
            .bind(iot_id)
            .fetch_one(db)
            .await?;
    Ok(row.0 > 0)
}

pub async fn register_iot(db: &PgPool, iot: &UserIotPair) -> Result<(), sqlx::Error> {
    let result = sqlx::query("insert into iot_user (id) values ($1)")
        .bind(iot.iot_id)
        .execute(db)
        .await;
    println!("Result: {:?}", result);
    Ok(())
}

pub async fn give_iot(db: &PgPool, iot: &UserIotPair) -> Result<(), sqlx::Error> {
    sqlx::query("update iot_user set user_id = $1 where id = $2")
        .bind(iot.user_id)
        .bind(iot.iot_id)
        .execute(db)
        .await?;
    Ok(())
}

pub async fn user_have_iot(db: &PgPool, user_id: i32) -> Result<bool, sqlx::Error> {
    let row: (i64,) = sqlx::query_as("select count(*) from iot_user where user_id = $1")
        .bind(user_id)
        .fetch_one(db)
        .await?;
    Ok(row.0 > 0)
}

pub async fn get_exercise_task(db: &PgPool, user_id: i32) -> Result<Id, sqlx::Error> {
    let row: (i32,) = sqlx::query_as("select next_exercise_id from iot_user where user_id = $1")
        .bind(user_id)
        .fetch_one(db)
        .await?;
    Ok(Id { id: row.0 })
}
