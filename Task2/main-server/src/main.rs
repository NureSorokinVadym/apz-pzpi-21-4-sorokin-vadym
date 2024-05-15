#[macro_use]
extern crate rocket;

use main_server::entrypoint as api;
use main_server::infrastructure::postgresql::DataBaseWraper;

#[launch]
async fn rocket() -> _ {
    rocket::build()
        .mount("/auth/", api::authorizations::get_routes())
        .attach(DataBaseWraper::init_database())
}
