#[macro_use]
extern crate rocket;

#[get("/")]
fn index() -> &'static str {
    "Hello, world!"
}

#[get("/ai")]
async fn ai_call() -> String {
    let response = reqwest::get("http://ai-service/").await.unwrap();
    response.text().await.unwrap()
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![index, ai_call])
}
