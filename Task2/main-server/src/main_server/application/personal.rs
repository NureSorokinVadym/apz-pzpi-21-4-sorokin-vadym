use super::authentication as auth;
use crate::domain::dto::*;
use crate::infrastructure::postgresql;

pub async fn create_personal(db: postgresql::MutDb, personal: &Personal) -> Result<i32, String> {
    postgresql::create_personal(db, personal.user_id, personal.specification_id)
        .await
        .unwrap();
    Ok(10)
}

pub async fn get_specifications(db: postgresql::MutDb) -> Vec<(i32, String)> {
    postgresql::get_specifications(db).await.unwrap()
}

pub async fn create_specification(
    mut db: postgresql::MutDb,
    token: &str,
    specification: &Specification,
) -> Result<i32, String> {
    let user_id = auth::validate_token(token)?;
    let user_access_level = postgresql::get_admin_access_level(&mut db, user_id).await;
    if user_access_level.unwrap_or(0) < 5 {
        return Err("User access level is not enough".to_string());
    }
    postgresql::create_specification(db, &specification)
        .await
        .unwrap();
    Ok(10)
}
