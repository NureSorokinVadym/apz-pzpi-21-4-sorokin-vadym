pub mod endpoints {
    use crate::application::personal as use_cases;
    use crate::entrypoint::{ApiKey, Json};

    use rocket::State;
    use sqlx::PgPool;

    use crate::domain::dto::*;

    #[post("/create_personal", format = "json", data = "<personal>")]
    pub async fn create_personal(
        db: &State<PgPool>,
        personal: Json<Personal>,
    ) -> Json<DefaultResponse> {
        println!("Creating personal: {}", personal.user_id);
        let result = use_cases::create_personal(db, &personal).await;
        Json::from(DefaultResponse::from(result))
    }
    #[post("/create_specification", format = "json", data = "<specification>")]
    pub async fn create_specification(
        db: &State<PgPool>,
        token: ApiKey<'_>,
        specification: Json<Specification>,
    ) -> Json<DefaultResponse> {
        println!("Creating specification: {}", specification.name);
        let result = use_cases::create_specification(db, token.into(), &specification).await;
        Json::from(DefaultResponse::from(result))
    }

    #[get("/specifications")]
    pub async fn get_specifications(db: &State<PgPool>) -> Json<Vec<(i32, String)>> {
        let specifications = use_cases::get_specifications(db).await;
        Json::from(specifications)
    }

    #[get("/get_clients")]
    pub async fn get_clients(db: &State<PgPool>, token: ApiKey<'_>) -> Json<Vec<User>> {
        let clients = use_cases::get_clients(db, token.into()).await;
        Json::from(clients)
    }
}

use endpoints::{create_personal, create_specification, get_specifications};
pub fn get_routes() -> Vec<rocket::Route> {
    routes![create_personal, create_specification, get_specifications]
}
