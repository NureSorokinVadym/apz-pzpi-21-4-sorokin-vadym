use rand::{thread_rng, Rng};
use serde::Deserialize;
use std::{thread::sleep, time::Duration};
use ureq;

macro_rules! create_jwt {
    () => {
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMSJ9.8tmzC05mGvYhPasy5gaKKdC0pg61vABLWW8yQkPaMHo"
    };
}

#[derive(Deserialize)]
struct AIResponse {
    will_continue: i8,
}

#[derive(Deserialize)]
struct CreateResponse {
    id: i32,
}

struct Sensors {
    pulse: i32,
    temperature: f32,
}

impl Sensors {
    fn new() -> Self {
        Self {
            pulse: 100,
            temperature: 36.6,
        }
    }

    fn update(&mut self) {
        self.pulse += thread_rng().gen_range(-2..3);
        self.temperature += thread_rng().gen_range(-0.05..0.1);
    }

    fn to_json(&self) -> ureq::serde_json::Value {
        ureq::json!({
            "pulse": self.pulse,
            "temperature": self.temperature
        })
    }
}

const TOKEN: &str = create_jwt!();

fn main() -> Result<(), ureq::Error> {
    let mut sensors = Sensors::new();

    let resp: CreateResponse = ureq::get("http://localhost/ai/exercises")
        .set("Authorization", &create_jwt!())
        .call()?
        .into_json()?;

    loop {
        let response: AIResponse = ureq::put(&format!("http://localhost/ai/exercises/{}", resp.id))
            .set("Authorization", &format!("Bearer {}", TOKEN))
            .send_json(sensors.to_json())?
            .into_json()?;

        println!("Continue for {}", response.will_continue);
        sensors.update();
        sleep(Duration::from_secs(1));
    }
}
