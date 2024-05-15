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

pub async fn create_user(mut db: MutDb, user: UserDTO) -> Result<i64, sqlx::Error> {
    let result: (i64,) = sqlx::query_as(
        "insert into user_base (email, name, surname, password_hash) values ($1, $2, $3, $4) returning id",
    )
    .bind(user.email)
    .bind(user.name)
    .bind(user.surname)
    .bind(user.password_hash)
    .fetch_one(&mut **db)
    .await?;

    Ok(result.0)
}

pub async fn get_user_id(db: &DataBaseWraper, email: &str) -> Result<u32, sqlx::Error> {
    let row: (i32,) = sqlx::query_as("select id from BaseUser where email = $1")
        .bind(email)
        .fetch_one(&db.0)
        .await?;
    Ok(row.0 as u32)
}

pub async fn get_user_with_password(
    db: &DataBaseWraper,
    email: &str,
) -> Result<(i64, String), sqlx::Error> {
    sqlx::query_as("select id, password from user_base where email = $1")
        .bind(email)
        .fetch_one(&db.0)
        .await
}

pub struct UserInfo {
    pub name: String,
    pub surname: String,
    pub email: String,
}

pub async fn get_user_info(db: &DataBaseWraper, user_id: i64) -> Result<UserInfo, sqlx::Error> {
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
