pub mod endpoints {
    use crate::application::admin as use_cases;
    use crate::entrypoint::{ApiKey, Json};
    use rocket::State;
    use sqlx::PgPool;

    use crate::domain::dto::*;

    #[post("/create_admin", format = "json", data = "<admin>")]
    pub async fn create_admin(
        db: &State<PgPool>,
        admin: Json<Admin>,
        api_key: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Creating admin: {}", admin.user_id);
        let result = use_cases::create_admin(db, api_key.into(), &admin).await;
        Json::from(DefaultResponse::from(result))
    }
}

use endpoints::create_admin;
pub fn get_routes() -> Vec<rocket::Route> {
    routes![create_admin]
}
