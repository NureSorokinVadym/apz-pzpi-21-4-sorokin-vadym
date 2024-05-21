use super::{sqlx, MutDb};

pub async fn create_admin(
    mut db: MutDb,
    user_id: i32,
    access_level: i32,
) -> Result<i32, sqlx::Error> {
    let _result = sqlx::query("insert into admin (user_id, access_level) values ($1, $2)")
        .bind(user_id)
        .bind(access_level)
        .execute(&mut **db)
        .await?;
    Ok(10)
}

pub async fn get_admin_access_level(db: &mut MutDb, user_id: i32) -> Result<i32, sqlx::Error> {
    let row: (i32,) = sqlx::query_as("select access_level from admin where user_id = $1")
        .bind(user_id)
        .fetch_one(&mut ***db)
        .await?;
    Ok(row.0)
}
