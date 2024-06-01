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
