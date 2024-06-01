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

// Місце для математичних розрахунків
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
