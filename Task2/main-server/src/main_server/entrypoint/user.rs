pub mod endpoints {
    use crate::application::user as use_cases;
    use crate::entrypoint::{ApiKey, Json};
    use rocket::State;
    use sqlx::PgPool;

    use crate::domain::dto::*;

    #[post("/give_reward", format = "json", data = "<reward>")]
    pub async fn give_reward(
        db: &State<PgPool>,
        reward: Json<UserRewardPair>,
        api_key: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Giving reward: {:?}", reward.user_id);
        let result = use_cases::give_reward(db, api_key.into(), &reward).await;
        Json::from(DefaultResponse::from(result))
    }

    #[post("/create_exercise", format = "json", data = "<exercise>")]
    pub async fn create_exercice(
        db: &State<PgPool>,
        exercise: Json<Exercise>,
        api_key: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Creating exercice: {}", exercise.name);
        let result = use_cases::create_exercice(db, api_key.into(), &exercise).await;
        Json::from(DefaultResponse::from(result))
    }

    #[post("/create_exercise_type", format = "json", data = "<exercise_type>")]
    pub async fn create_exercice_type(
        db: &State<PgPool>,
        exercise_type: Json<ExerciceType>,
        api_key: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Creating exercice type: {}", exercise_type.name);
        let result = use_cases::create_exercise_type(db, api_key.into(), &exercise_type).await;
        Json::from(DefaultResponse::from(result))
    }

    #[get("/exercices")]
    pub async fn get_exercices(db: &State<PgPool>) -> Json<Vec<(i32, String)>> {
        let exercices = use_cases::get_exercices(db).await;
        Json::from(exercices)
    }

    #[post("/give_exercice", format = "json", data = "<exercise_user>")]
    pub async fn give_exercice(
        db: &State<PgPool>,
        token: ApiKey<'_>,
        mut exercise_user: Json<UserExercisePair>,
    ) -> Json<DefaultResponse> {
        println!("Giving exercice: {}", exercise_user.exercise_id);
        let result = use_cases::give_exercice(db, token.into(), &mut exercise_user).await;
        Json::from(DefaultResponse::from(result))
    }

    #[get("/get_exercises_types", format = "json")]
    pub async fn get_exercises_types(db: &State<PgPool>) -> Json<Vec<(i32, String)>> {
        Json::from(use_cases::get_exercises_types(db).await)
    }

    #[post("/give_me_exercise", format = "json", data = "<user_exercise>")]
    pub async fn give_me_exercise(
        db: &State<PgPool>,
        token: ApiKey<'_>,
        mut user_exercise: Json<UserExercisePair>,
    ) -> Json<DefaultResponse> {
        println!("Giving exercice: {}", user_exercise.exercise_id);
        let result = use_cases::give_exercice(db, token.into(), &mut user_exercise).await;
        Json::from(DefaultResponse::from(result))
    }

    #[post("/create_reward", format = "json", data = "<reward>")]
    pub async fn create_reward(
        db: &State<PgPool>,
        api_key: ApiKey<'_>,
        reward: Json<Reward>,
    ) -> Json<DefaultResponse> {
        println!("Creating reward: {}", reward.name);
        let result = use_cases::create_reward(db, api_key.into(), &reward).await;
        Json::from(DefaultResponse::from(result))
    }

    #[get("/get_exercises")]
    pub async fn get_exercises(db: &State<PgPool>, token: ApiKey<'_>) -> Json<Vec<ExerciseUser>> {
        let exercises = use_cases::get_exercises(db, token.into()).await;
        match exercises {
            Ok(exs) => Json::from(exs),
            Err(_) => Json::from(vec![]),
        }
    }

    #[post("/register_iot", format = "json", data = "<iot>")]
    pub async fn register_iot(db: &State<PgPool>, iot: Json<UserIotPair>) -> Json<DefaultResponse> {
        println!("Registering iot: {}", iot.iot_id);
        if let Err(e) = use_cases::register_iot(db, &iot).await {
            println!("Error: {:?}", e);
            return Json::from(DefaultResponse::new(e));
        }
        Json::from(DefaultResponse::new("Success".to_string()))
    }

    #[post("/give_iot", format = "json", data = "<iot>")]
    pub async fn give_iot(
        db: &State<PgPool>,
        token: ApiKey<'_>,
        iot: Json<UserIotPair>,
    ) -> Json<DefaultResponse> {
        println!("Giving iot: {} to {:?}", iot.iot_id, iot.user_id);
        let result = use_cases::give_iot(db, token.into(), &iot).await;
        if let Err(e) = result {
            return Json::from(DefaultResponse::new(e));
        }
        Json::from(DefaultResponse::new("Success".to_string()))
    }

    #[get("/have_iot")]
    pub async fn have_iot(db: &State<PgPool>, token: ApiKey<'_>) -> Json<bool> {
        let result = use_cases::have_iot(db, token.into()).await;
        Json::from(result.unwrap_or(false))
    }

    #[post("/set_exercise_task", format = "json", data = "<exercise_task_id>")]
    pub async fn set_exercise_task(
        db: &State<PgPool>,
        token: ApiKey<'_>,
        exercise_task_id: Json<Id>,
    ) -> Json<DefaultResponse> {
        use_cases::set_exercise_task(db, token.into(), &exercise_task_id)
            .await
            .unwrap();
        Json::from(DefaultResponse::new("Success".to_string()))
    }

    #[get("/get_exercise_task")]
    pub async fn get_exercise_task(db: &State<PgPool>, token: ApiKey<'_>) -> Json<Id> {
        let result = use_cases::get_exercise_task(db, token.into())
            .await
            .unwrap_or(Id { id: -1 });
        Json::from(result)
    }
}

pub fn get_routes() -> Vec<rocket::Route> {
    routes![
        endpoints::give_reward,
        endpoints::create_reward,
        endpoints::create_exercice,
        endpoints::get_exercices,
        endpoints::give_exercice,
        endpoints::give_me_exercise,
        endpoints::create_exercice_type,
        endpoints::get_exercises_types,
        endpoints::get_exercises,
        endpoints::register_iot,
        endpoints::give_iot,
        endpoints::have_iot,
        endpoints::set_exercise_task,
        endpoints::get_exercise_task,
    ]
}
