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

    #[post("/create_personal", format = "json", data = "<personal>")]
    pub async fn create_personal(
        db: &State<PgPool>,
        personal: Json<Personal>,
        api_key: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Creating personal: {}", personal.user_id);
        let result = use_cases::create_personal(db, api_key.into(), &personal).await;
        Json::from(DefaultResponse::from(result))
    }

    #[delete("/delete_exercise/<id>")]
    pub async fn delete_exercise(
        db: &State<PgPool>,
        id: i32,
        api_key: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Deleting exercise: {}", id);
        use_cases::delete_exercise(db, api_key.into(), &Id { id })
            .await
            .unwrap();
        Json::from(DefaultResponse::new("Success".to_string()))
    }
    #[get("/make_backup")]
    pub async fn make_backup(db: &State<PgPool>, api_key: ApiKey<'_>) -> Json<Vec<User>> {
        println!("Making backup");
        let users = use_cases::make_backup(db, api_key.into()).await.unwrap();
        Json::from(users)
    }
}

use endpoints::*;
pub fn get_routes() -> Vec<rocket::Route> {
    routes![create_admin, create_personal, delete_exercise, make_backup]
}
