pub mod authorizations {
    use rocket::serde::json::Json;

    pub mod dto {

        use rocket::serde::{Deserialize, Serialize};

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct LogInDtoRequest {
            pub email: String,
            pub password: String,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct LogInDtoResponse {
            pub token: String,
            pub message: u32,
        }

        #[derive(Debug, Serialize, Deserialize)]
        #[serde(crate = "rocket::serde")]
        pub struct LogUpDtoRequest {
            pub email: String,
            pub name: String,
            pub surname: String,
            pub password: String,
        }
    }

    use crate::application::use_cases;
    use crate::infrastructure::postgresql::{create_user, DataBaseWraper, MutDb, UserDTO};

    #[post("/log_up", format = "json", data = "<log_up>")]
    pub async fn log_up(
        mut db: MutDb,
        log_up: Json<dto::LogUpDtoRequest>,
    ) -> Json<dto::LogInDtoResponse> {
        println!("Creating user: {}", log_up.email);
        let result = create_user(
            db,
            UserDTO::new(
                log_up.email.clone(),
                log_up.name.clone(),
                log_up.surname.clone(),
                log_up.password.clone(),
            ),
        )
        .await;

        if let Ok(_) = result {
            return Json::from(dto::LogInDtoResponse {
                token: "unknow".to_string(),
                message: 200,
            });
        }
        Json::from(dto::LogInDtoResponse {
            token: "unknow".to_string(),
            message: 400,
        })
    }

    #[post("/log_in", format = "json", data = "<log_in>")]
    pub async fn log_in(
        db: &DataBaseWraper,
        log_in: Json<dto::LogInDtoRequest>,
    ) -> Json<dto::LogInDtoResponse> {
        println!("Loging in user: {}", log_in.email);
        if let Ok(token) = use_cases::get_token(db, &log_in.email, &log_in.password).await {
            return Json::from(dto::LogInDtoResponse {
                token,
                message: 200,
            });
        }
        Json::from(dto::LogInDtoResponse {
            token: "unknow".to_string(),
            message: 400,
        })
    }

    pub fn get_routes() -> Vec<rocket::Route> {
        routes![log_up, log_in]
    }
}
