pub mod endpoints {
    use crate::application::personal as use_cases;
    use crate::entrypoint::{ApiKey, Json};
    use std::collections::HashMap;

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
    pub async fn get_specifications(db: &State<PgPool>) -> Json<HashMap<i32, String>> {
        let specifications = use_cases::get_specifications(db).await;
        Json::from(specifications)
    }

    #[get("/get_clients")]
    pub async fn get_clients(db: &State<PgPool>, token: ApiKey<'_>) -> Json<Vec<User>> {
        let clients = use_cases::get_clients(db, token.into()).await;
        Json::from(clients)
    }

    #[get("/get_exercises/<user_id>")]
    pub async fn get_exercises(
        db: &State<PgPool>,
        api: ApiKey<'_>,
        user_id: i32,
    ) -> Json<Vec<ExerciseUser>> {
        let exercises = use_cases::get_client_exercises(db, api.into(), user_id).await;
        Json::from(exercises)
    }

    #[get("/get_exercises_list")]
    pub async fn get_exercises_list(db: &State<PgPool>) -> Json<Vec<Exercise>> {
        let exercises = use_cases::get_exercises_list(db).await;
        Json::from(exercises)
    }

    #[post("/add_exercise", format = "json", data = "<pair>")]
    pub async fn add_exercise(db: &State<PgPool>, api: ApiKey<'_>, pair: Json<UserExercisePair>) {
        let _result = use_cases::add_exercise(db, api.into(), &pair).await;
    }

    #[get("/get_exercise_types")]
    pub async fn get_exercise_types(db: &State<PgPool>) -> Json<HashMap<i32, String>> {
        let types = use_cases::get_exercise_types(db).await;
        Json::from(types)
    }
}

use endpoints::*;
pub fn get_routes() -> Vec<rocket::Route> {
    routes![
        create_personal,
        create_specification,
        get_specifications,
        get_clients,
        get_exercises,
        get_exercises_list,
        add_exercise,
        get_exercise_types
    ]
}
