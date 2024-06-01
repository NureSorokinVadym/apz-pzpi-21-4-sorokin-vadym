use sqlx::postgres::PgPoolOptions;

pub async fn get_pool() -> sqlx::Pool<sqlx::Postgres> {
    let db_url =
        std::env::var("DATABASE_URL").unwrap_or("postgres://user:password@database/db".to_string());
    PgPoolOptions::new()
        .max_connections(5)
        .connect(&db_url)
        .await
        .unwrap()
}

pub mod admin_repo;
pub mod authentication;
pub mod personal_repo;
pub mod user_repo;
