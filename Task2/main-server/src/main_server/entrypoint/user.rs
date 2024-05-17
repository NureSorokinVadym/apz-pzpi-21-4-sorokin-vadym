pub mod endpoints {
    use crate::application::use_cases;
    use crate::entrypoint::authentication::jwt_provider::ApiKey;
    use crate::infrastructure::postgresql::MutDb;
    use rocket::serde::json::Json;

    use crate::domain::dto::*;

    #[post("/give_reward", format = "json", data = "<reward>")]
    pub async fn give_reward(
        db: MutDb,
        reward: Json<UserRewardPair>,
        api_key: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Giving reward: {:?}", reward.user_id);
        let result = use_cases::give_reward(
            db,
            api_key.into(),
            reward.user_id.unwrap(),
            reward.reward_id,
        )
        .await;
        Json::from(DefaultResponse::new(
            result.unwrap_or_else(|err| err.to_string()),
        ))
    }

    #[post("/create_exercice", format = "json", data = "<exercice>")]
    pub async fn create_exercice(
        db: MutDb,
        exercice: Json<Exercise>,
        api_key: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Creating exercice: {}", exercice.name);
        let result = use_cases::create_exercice(
            db,
            api_key.into(),
            use_cases::ExerciceCreateRequest {
                name: exercice.name.clone(),
                measurement: exercice.measurement.clone(),
                exercice_type_id: exercice.exercice_type_id,
            },
        )
        .await;
        Json::from(DefaultResponse::new(result.unwrap_or_else(|err| err)))
    }

    #[post("/create_exercice_type", format = "json", data = "<exercice_type>")]
    pub async fn create_exercice_type(
        db: MutDb,
        exercice_type: Json<ExerciceType>,
        api_key: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Creating exercice type: {}", exercice_type.name);
        let result =
            use_cases::create_exercice_type(db, api_key.into(), exercice_type.name.clone()).await;
        Json::from(DefaultResponse::new(result.unwrap_or_else(|err| err)))
    }

    #[get("/exercices")]
    pub async fn get_exercices(db: MutDb) -> Json<Vec<(i32, String)>> {
        let exercices = use_cases::get_exercices(db).await;
        Json::from(exercices)
    }

    #[post("/give_exercice", format = "json", data = "<exercice>")]
    pub async fn give_exercice(
        db: MutDb,
        exercice: Json<DefaultResponse>,
    ) -> Json<DefaultResponse> {
        println!("Giving exercice: {}", exercice.user_id);
        let result = use_cases::give_exercice(db, exercice.user_id, exercice.exercice_id).await;
        Json::from(DefaultResponse::new(result.unwrap_or_else(|err| err)))
    }

    #[post("/give_me_exercise", format = "json", data = "<exercice>")]
    pub async fn give_me_exercise(
        db: MutDb,
        exercice: Json<UserExercisePair>,
        token: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Giving exercice: {}", exercice.exercise_id);
        let user_id = use_cases::authorizations::validate_token(token.into()).unwrap();
        let result = use_cases::give_exercice(db, user_id, exercice.exercise_id).await;
        Json::from(DefaultResponse::new(result.unwrap_or_else(|err| err)))
    }

    #[post("/create_reward", format = "json", data = "<reward>")]
    pub async fn create_reward(
        db: MutDb,
        reward: Json<Reward>,
        api_key: ApiKey<'_>,
    ) -> Json<DefaultResponse> {
        println!("Creating reward: {}", reward.name);
        let result = use_cases::create_reward(
            db,
            api_key.into(),
            reward.name.clone(),
            reward.condition.clone(),
        )
        .await;
        Json::from(DefaultResponse::new(result.unwrap_or_else(|err| err)))
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
    ]
}
