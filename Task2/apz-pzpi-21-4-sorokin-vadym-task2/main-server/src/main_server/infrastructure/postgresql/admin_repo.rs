use crate::domain::dto::*;
use sqlx::PgPool;

pub async fn create_admin(
    db: &PgPool,
    user_id: i32,
    access_level: i32,
) -> Result<i32, sqlx::Error> {
    let _result = sqlx::query("insert into admin (user_id, access_level) values ($1, $2)")
        .bind(user_id)
        .bind(access_level)
        .execute(db)
        .await?;
    Ok(10)
}

pub async fn get_admin_access_level(db: &PgPool, user_id: i32) -> Result<i32, sqlx::Error> {
    let row: (i32,) = sqlx::query_as("select access_level from admin where user_id = $1")
        .bind(user_id)
        .fetch_one(db)
        .await?;
    Ok(row.0)
}

pub async fn is_admin(db: &PgPool, user_id: i32) -> Result<bool, sqlx::Error> {
    let row: (i64,) = sqlx::query_as("select count(*) from admin where user_id = $1")
        .bind(user_id)
        .fetch_one(db)
        .await?;
    Ok(row.0 > 0)
}

pub async fn create_personal(db: &PgPool, personal: &Personal) -> Result<i32, sqlx::Error> {
    let _result = sqlx::query("insert into personal (user_id, specification_id) values ($1, $2)")
        .bind(personal.user_id)
        .bind(personal.specification_id)
        .execute(db)
        .await?;
    Ok(5)
}

pub async fn delete_exercise(db: &PgPool, id: &Id) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("delete from exercice where id = $1")
        .bind(id.id)
        .execute(db)
        .await?;
    Ok(())
}

pub async fn make_backup(db: &PgPool) -> Result<Vec<User>, sqlx::Error> {
    let rows: Vec<(i32, Option<String>, Option<String>, String)> =
        sqlx::query_as("select id, name, surname, email from user_base")
            .fetch_all(db)
            .await?;
    Ok(rows
        .into_iter()
        .map(|row| User {
            id: Some(row.0),
            name: row.1,
            surname: row.2,
            email: row.3,
            password: None,
        })
        .collect())
}
