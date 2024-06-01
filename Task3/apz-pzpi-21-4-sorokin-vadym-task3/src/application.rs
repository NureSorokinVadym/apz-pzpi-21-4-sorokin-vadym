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
