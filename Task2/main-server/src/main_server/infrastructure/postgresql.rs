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

pub async fn create_user(mut db: MutDb, user: UserDTO) -> Result<(), sqlx::Error> {
    sqlx::query(
        "insert into user_base (email, name, surname, password_hash) values ($1, $2, $3, $4)",
    )
    .bind(user.email)
    .bind(user.name)
    .bind(user.surname)
    .bind(user.password_hash)
    .execute(&mut **db)
    .await?;
    Ok(())
}

pub async fn get_user_id(db: &DataBaseWraper, email: &str) -> Result<u32, sqlx::Error> {
    let row: (i32,) = sqlx::query_as("select id from BaseUser where email = $1")
        .bind(email)
        .fetch_one(&db.0)
        .await?;
    Ok(row.0 as u32)
}

pub async fn get_user(db: &DataBaseWraper, email: &str) -> Result<String, sqlx::Error> {
    let row: (String,) = sqlx::query_as("select name from BaseUser where id = $1")
        .bind(email)
        .fetch_one(&db.0)
        .await?;
    Ok(row.0)
}
