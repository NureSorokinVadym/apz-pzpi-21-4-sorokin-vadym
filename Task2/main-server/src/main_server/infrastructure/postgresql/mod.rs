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

pub mod admin_repo;
pub mod authentication;
pub mod personal_repo;
pub mod user_repo;
