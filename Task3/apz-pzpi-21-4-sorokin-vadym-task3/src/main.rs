use iot::domain as dto;
use iot::presentation as p;

#[tokio::main]
async fn main() {
    let mut setting = p::registration().await;
    let mut sensors = dto::Sensors::new();
    loop {
        let option = p::choose_option();
        match option.as_str() {
            "1" => {
                p::start_exercise(&setting).await;
                p::predict_pooling(&mut sensors, &setting).await;
            }
            "2" => {
                setting = p::update_setting().await;
            }
            "3" => {
                break;
            }
            _ => {
                println!("Invalid option");
            }
        }
    }
}
