
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
