use crate::domain::dto::*;
use sqlx::PgPool;

pub async fn create_user(db: &PgPool, user: &User) -> Result<i32, sqlx::Error> {
    let result: (i32,) = sqlx::query_as(
        "insert into user_base (email, name, surname, password_hash) values ($1, $2, $3, $4) returning id",
    )
    .bind(&user.email)
    .bind(&user.name)
    .bind(&user.surname)
    .bind(&user.password)
    .fetch_one(db)
    .await?;

    Ok(result.0)
}

pub async fn get_user_id(db: &PgPool, email: &str) -> Result<i32, sqlx::Error> {
    let row: (i32,) = sqlx::query_as("select id from user_base where email = $1")
        .bind(email)
        .fetch_one(db)
        .await?;
    Ok(row.0)
}

pub async fn get_user_with_password(
    db: &PgPool,
    email: &str,
) -> Result<(i32, String), sqlx::Error> {
    sqlx::query_as("select id, password_hash from user_base where email = $1")
        .bind(email)
        .fetch_one(db)
        .await
}

pub async fn create_personal(
    db: &PgPool,
    user_id: i32,
    specification_id: i32,
) -> Result<i32, sqlx::Error> {
    let _result = sqlx::query("insert into personal (user_id, specification_id) values ($1, $2)")
        .bind(user_id)
        .bind(specification_id)
        .execute(db)
        .await?;
    Ok(3)
}

pub async fn is_personal(db: &PgPool, user_id: i32) -> Result<bool, sqlx::Error> {
    let row: (i64,) = sqlx::query_as("select count(*) from personal where user_id = $1")
        .bind(user_id)
        .fetch_one(db)
        .await?;
    Ok(row.0 > 0)
}
