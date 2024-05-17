pub mod endpoints {
    use crate::application::use_cases;
    use crate::entrypoint::authentication::jwt_provider::ApiKey;
    use crate::infrastructure::postgresql::MutDb;
    use rocket::serde::json::Json;

    use crate::domain::dto::*;

    #[post("/create_admin", format = "json", data = "<admin>")]
    pub async fn create_admin(
        db: MutDb,
        admin: Json<Admin>,
        api_key: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Creating admin: {}", admin.user_id);
        let result = use_cases::create_admin(
            db,
            api_key.into(),
            use_cases::AdminCreateRequest {
                id: admin.user_id,
                access_level: admin.access_level,
            },
        )
        .await;
        Json::from(DefaultResponse::new(result.unwrap_or_else(|err| err)))
    }
}

use endpoints::create_admin;
pub fn get_routes() -> Vec<rocket::Route> {
    routes![create_admin]
}
