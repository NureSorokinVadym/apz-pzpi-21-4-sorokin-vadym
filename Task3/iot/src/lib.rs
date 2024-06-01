pub mod domain {
    use rand::{thread_rng, Rng};
    use serde::{Deserialize, Serialize};

    #[derive(Deserialize)]
    pub struct DefaultResponse {
        pub id: Option<i32>,
        pub message: String,
    }

    impl DefaultResponse {
        pub fn new(message: String) -> Self {
            Self { id: None, message }
        }
    }

    #[derive(Serialize)]
    pub struct ExerciseDuration {
        pub duration: i32,
    }

    #[derive(Deserialize)]
    pub struct Settings {
        pub token: String,
    }

    impl Settings {
        pub fn new(token: String) -> Self {
            Self { token }
        }
    }

    #[derive(Serialize)]
    pub struct Sensors {
        pub pulse: i32,
        pub temperature: f32,
    }

    impl Sensors {
        pub fn new() -> Self {
            Self {
                pulse: 100,
                temperature: 36.6,
            }
        }

        pub fn update(&mut self) {
            self.pulse += thread_rng().gen_range(-2..3);
            self.temperature += thread_rng().gen_range(-0.05..0.1);
        }
    }
}

pub mod application {

    use crate::domain as dto;
    use crate::infostructure::http;

    pub async fn registration() -> dto::DefaultResponse {
        http::registration().await;
        dto::DefaultResponse::new(String::from("Registration success"))
    }

    pub async fn get_token() -> dto::Settings {
        http::get_token().await
    }

    pub async fn start_exercise(settings: &dto::Settings) -> dto::DefaultResponse {
        http::start_exercise(settings).await
    }

    pub async fn get_predict(
        data: &mut dto::Sensors,
        settings: &dto::Settings,
    ) -> dto::DefaultResponse {
        data.update();
        http::get_predict(data, settings).await
    }

    pub async fn end_exercise(settings: &dto::Settings) -> dto::DefaultResponse {
        http::end_exercise(settings).await
    }
}

pub mod infostructure {
    pub mod http {
        use crate::domain::{DefaultResponse, Sensors, Settings};
        use ureq::{patch, post};

        const URL: &'static str = "http://localhost";
        pub const ID: i32 = 1_000_999;

        pub async fn registration() {
            ureq::post(&format!("{}/api/user/register_iot", URL))
                .send_json(ureq::json!({
                    "iot_id": ID,
                }))
                .unwrap();
        }

        pub async fn get_token() -> Settings {
            ureq::get(&format!("{}/ai/setting", URL))
                .set("Authorization", ID.to_string().as_str())
                .call()
                .unwrap()
                .into_json()
                .unwrap()
        }

        pub async fn start_exercise(settings: &Settings) -> DefaultResponse {
            patch(&format!("{}/ai/start_exercise", URL))
                .set("Authorization", settings.token.as_str())
                .call()
                .unwrap()
                .into_json()
                .unwrap()
        }

        pub async fn get_predict(data: &Sensors, settings: &Settings) -> DefaultResponse {
            post(&format!("{}/ai/predict", URL))
                .set("Authorization", settings.token.as_str())
                .send_json(data)
                .unwrap()
                .into_json()
                .unwrap()
        }

        pub async fn end_exercise(settings: &Settings) -> DefaultResponse {
            patch(&format!("{}/ai/end_exercise", URL))
                .set("Authorization", settings.token.as_str())
                .send_json(ureq::json!({
                "iot_id": ID,
                }))
                .unwrap()
                .into_json()
                .unwrap()
        }
    }
}

pub mod presentation {
    use crate::application as app;
    use crate::domain::Settings;
    use crate::infostructure::http::ID;
    use std::thread;

    pub fn choose_option() -> String {
        println!("1. Start exercise");
        println!("2. Update settings");
        println!("3. Exit");
        let mut option = String::new();
        std::io::stdin().read_line(&mut option).unwrap();
        // Remove endline
        option.pop();
        option
    }

    pub async fn registration() -> Settings {
        let result = app::registration().await;
        println!(
            "{}\nWaiting for pairing with {}, press Enter for continue",
            result.message, ID
        );
        let _ = std::io::stdin().read_line(&mut String::new());
        app::get_token().await
    }

    pub async fn update_setting() -> Settings {
        let settings = app::get_token().await;
        println!("Token: {}", settings.token);
        settings
    }

    pub async fn start_exercise(settings: &Settings) {
        let result = app::start_exercise(settings).await;
        println!("{}", result.message);
    }
    pub async fn predict_pooling(data: &mut crate::domain::Sensors, settings: &Settings) {
        for _ in 1..3 {
            let result = app::get_predict(data, settings).await;
            println!("{}", result.message);
            thread::sleep(std::time::Duration::from_secs(1));
        }
        let result = app::end_exercise(settings).await;
        println!("{}", result.message);
    }
}
