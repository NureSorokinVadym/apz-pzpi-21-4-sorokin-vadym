pub mod endpoints {
    use crate::application::use_cases;
    use crate::entrypoint::authentication::jwt_provider::ApiKey;
    use crate::infrastructure::postgresql::MutDb;
    use rocket::serde::json::Json;

    use crate::domain::dto::*;

    #[post("/create_personal", format = "json", data = "<personal>")]
    pub async fn create_personal(db: MutDb, personal: Json<Personal>) -> Json<DefaultResponse> {
        println!("Creating personal: {}", personal.user_id);
        let result = use_cases::create_personal(
            db,
            use_cases::PersonalCreateRequest {
                user_id: personal.user_id,
                specification_id: personal.specification_id,
            },
        )
        .await;
        Json::from(DefaultResponse::new(result.unwrap_or(|err| err)))
    }
    #[post("/create_specification", format = "json", data = "<specification>")]
    pub async fn create_specification(
        db: MutDb,
        specification: Json<Specification>,
        token: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Creating specification: {}", specification.name);
        let result =
            use_cases::create_specification(db, token.into(), specification.name.clone()).await;

        Json::from(DefaultResponse::new(result.unwrap_or(|err| err)))
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
