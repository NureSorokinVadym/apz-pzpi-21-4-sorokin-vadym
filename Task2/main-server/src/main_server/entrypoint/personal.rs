pub mod endpoints {
    use crate::application::personal as use_cases;
    use crate::entrypoint::{ApiKey, Json};
    use crate::infrastructure::postgresql::MutDb;

    use crate::domain::dto::*;

    #[post("/create_personal", format = "json", data = "<personal>")]
    pub async fn create_personal(db: MutDb, personal: Json<Personal>) -> Json<DefaultResponse> {
        println!("Creating personal: {}", personal.user_id);
        let result = use_cases::create_personal(db, &personal).await;
        Json::from(DefaultResponse::from(result))
    }
    #[post("/create_specification", format = "json", data = "<specification>")]
    pub async fn create_specification(
        db: MutDb,
        token: ApiKey<'_>,
        specification: Json<Specification>,
    ) -> Json<DefaultResponse> {
        println!("Creating specification: {}", specification.name);
        let result = use_cases::create_specification(db, token.into(), &specification).await;
        Json::from(DefaultResponse::from(result))
    }

    #[get("/specifications")]
    pub async fn get_specifications(db: MutDb) -> Json<Vec<(i32, String)>> {
        let specifications = use_cases::get_specifications(db).await;
        Json::from(specifications)
    }
}

use endpoints::{create_personal, create_specification, get_specifications};
pub fn get_routes() -> Vec<rocket::Route> {
    routes![create_personal, create_specification, get_specifications]
}
