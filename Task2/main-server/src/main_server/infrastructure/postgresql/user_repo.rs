use super::{sqlx, DataBaseWraper, MutDb};
use crate::domain::dto::*;

pub async fn get_user_info(db: &DataBaseWraper, user_id: i32) -> Result<User, sqlx::Error> {
    let row: (String, String, String) =
        sqlx::query_as("select email, name, surname from user_base where id = $1")
            .bind(user_id)
            .fetch_one(&db.0)
            .await?;
    Ok(User::new_basic(row.0, row.1, row.2))
}
pub async fn get_exercices(db: &mut MutDb) -> Result<Vec<(i32, String)>, sqlx::Error> {
    let rows: Vec<(i32, String)> = sqlx::query_as("select id, name from exercice")
        .fetch_all(&mut ***db)
        .await?;
    Ok(rows)
}

pub async fn get_exercise_types(db: &mut MutDb) -> Result<Vec<(i32, String)>, sqlx::Error> {
    let rows: Vec<(i32, String)> = sqlx::query_as("select id, name from exercice_type")
        .fetch_all(&mut ***db)
        .await?;
    Ok(rows)
}