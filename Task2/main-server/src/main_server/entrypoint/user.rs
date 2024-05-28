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
        endpoints::get_exercises
    ]
}
