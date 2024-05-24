#[macro_use]
extern crate rocket;

use main_server::entrypoint as api;
use main_server::infrastructure::postgresql::get_pool;

use rocket::http::Method;
use rocket_cors::{AllowedOrigins, CorsOptions};

#[launch]
async fn rocket() -> _ {
    let cors = CorsOptions::default()
        .allowed_origins(AllowedOrigins::all())
        .allowed_methods(
            vec![Method::Get, Method::Post, Method::Put, Method::Delete]
                .into_iter()
                .map(From::from)
                .collect(),
        )
        .allow_credentials(true);
    let pool = get_pool().await;

    rocket::build()
        .mount("/auth/", api::authentication::get_routes())
        .mount("/personal/", api::personal::get_routes())
        .mount("/admin/", api::admin::get_routes())
        .mount("/user/", api::user::get_routes())
        .attach(cors.to_cors().unwrap())
        .manage(pool)
}
