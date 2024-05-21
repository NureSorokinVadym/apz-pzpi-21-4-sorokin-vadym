use super::{sqlx, DataBaseWraper, MutDb};
use crate::domain::dto::*;

pub async fn create_user(db: &mut MutDb, user: &User) -> Result<i32, sqlx::Error> {
    let result: (i32,) = sqlx::query_as(
        "insert into user_base (email, name, surname, password_hash) values ($1, $2, $3, $4) returning id",
    )
    .bind(&user.email)
    .bind(&user.name)
    .bind(&user.surname)
    .bind(&user.password)
    .fetch_one(&mut ***db)
    .await?;

    Ok(result.0)
}

pub async fn get_user_id(db: &mut MutDb, email: &str) -> Result<i32, sqlx::Error> {
    let row: (i32,) = sqlx::query_as("select id from user_base where email = $1")
        .bind(email)
        .fetch_one(&mut ***db)
        .await?;
    Ok(row.0)
}

pub async fn get_user_with_password(
    db: &DataBaseWraper,
    email: &str,
) -> Result<(i32, String), sqlx::Error> {
    sqlx::query_as("select id, password_hash from user_base where email = $1")
        .bind(email)
        .fetch_one(&db.0)
        .await
}

pub async fn create_personal(
    mut db: MutDb,
    user_id: i32,
    specification_id: i32,
) -> Result<i32, sqlx::Error> {
    let _result = sqlx::query("insert into personal (user_id, specification_id) values ($1, $2)")
        .bind(user_id)
        .bind(specification_id)
        .execute(&mut **db)
        .await?;
    Ok(3)
}

pub async fn is_personal(db: &mut MutDb, user_id: i32) -> bool {
    let row: Option<_> = sqlx::query("select user_id from personal where user_id = $1")
        .bind(user_id)
        .fetch_optional(&mut ***db)
        .await
        .unwrap();
    row.is_some()
}
