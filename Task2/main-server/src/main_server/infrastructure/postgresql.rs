use crate::domain::dto::*;
use rocket_db_pools::{sqlx, Connection, Database, Initializer};

#[derive(Database)]
#[database("db")]
pub struct DataBaseWraper(sqlx::PgPool);

impl DataBaseWraper {
    pub fn init_database() -> Initializer<DataBaseWraper> {
        DataBaseWraper::init()
    }
}

pub type MutDb = Connection<DataBaseWraper>;

pub struct UserDTO {
    email: String,
    name: String,
    surname: String,
    password_hash: String,
}

impl UserDTO {
    pub fn new(email: String, name: String, surname: String, password_hash: String) -> Self {
        Self {
            email,
            name,
            surname,
            password_hash,
        }
    }
}

pub async fn create_user(db: &mut MutDb, user: UserDTO) -> Result<i32, sqlx::Error> {
    let result: (i32,) = sqlx::query_as(
        "insert into user_base (email, name, surname, password_hash) values ($1, $2, $3, $4) returning id",
    )
    .bind(user.email)
    .bind(user.name)
    .bind(user.surname)
    .bind(user.password_hash)
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

pub struct UserInfo {
    pub name: String,
    pub surname: String,
    pub email: String,
}

pub async fn get_user_info(db: &DataBaseWraper, user_id: i32) -> Result<UserInfo, sqlx::Error> {
    let row: (String, String, String) =
        sqlx::query_as("select name, surname, email from user_base where id = $1")
            .bind(user_id)
            .fetch_one(&db.0)
            .await?;
    Ok(UserInfo {
        name: row.0,
        surname: row.1,
        email: row.2,
    })
}

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

pub async fn create_personal(
    mut db: MutDb,
    user_id: i32,
    specification_id: i32,
) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into personal (user_id, specification_id) values ($1, $2)")
        .bind(user_id)
        .bind(specification_id)
        .execute(&mut **db)
        .await?;
    Ok(())
}

pub async fn create_specification(
    mut db: MutDb,
    specification: &Specification,
) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into specification (name) values ($1)")
        .bind(&specification.name)
        .execute(&mut **db)
        .await?;
    Ok(())
}

pub async fn get_specifications(mut db: MutDb) -> Result<Vec<(i32, String)>, sqlx::Error> {
    let rows: Vec<(i32, String)> = sqlx::query_as("select id, name from specification")
        .fetch_all(&mut **db)
        .await?;
    Ok(rows)
}

pub async fn is_personal(db: &mut MutDb, user_id: i32) -> bool {
    let row: Option<_> = sqlx::query("select user_id from personal where user_id = $1")
        .bind(user_id)
        .fetch_optional(&mut ***db)
        .await
        .unwrap();
    row.is_some()
}

pub async fn give_reward(db: &mut MutDb, user_id: i32, reward: i32) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into reward_user (reward_id, user_id) values ($1, $2)")
        .bind(reward)
        .bind(user_id)
        .execute(&mut ***db)
        .await?;
    Ok(())
}

pub struct ExerciceCreateRequest {
    pub name: String,
    pub measurement: String,
    pub exercice_type_id: i32,
}

pub async fn create_exercice(
    db: &mut MutDb,
    name: &str,
    measurement: &str,
    exercice_type_id: i32,
) -> Result<(), sqlx::Error> {
    let _result = sqlx::query(
        "insert into exercice (name, measurement, exercice_type_id) values ($1, $2, $3)",
    )
    .bind(name)
    .bind(measurement)
    .bind(exercice_type_id)
    .execute(&mut ***db)
    .await?;
    Ok(())
}

pub async fn get_exercices(db: &mut MutDb) -> Result<Vec<(i32, String)>, sqlx::Error> {
    let rows: Vec<(i32, String)> = sqlx::query_as("select id, name from exercice")
        .fetch_all(&mut ***db)
        .await?;
    Ok(rows)
}

pub async fn give_exercice(
    db: &mut MutDb,
    user_id: i32,
    exercice_id: i32,
) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into exercice_user (user_id, exercice_id) values ($1, $2)")
        .bind(user_id)
        .bind(exercice_id)
        .execute(&mut ***db)
        .await?;
    Ok(())
}

pub async fn create_exercice_type(db: &mut MutDb, name: &str) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into exercice_type (name) values ($1)")
        .bind(name)
        .execute(&mut ***db)
        .await?;
    Ok(())
}

pub async fn create_reward(db: &mut MutDb, name: &str, condition: &str) -> Result<(), sqlx::Error> {
    let _result = sqlx::query("insert into reward (name, condition) values ($1, $2)")
        .bind(name)
        .bind(condition)
        .execute(&mut ***db)
        .await?;
    Ok(())
}
