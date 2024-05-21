use super::authentication as auth;
use crate::domain::dto::*;
use crate::infrastructure::postgresql::{self, admin_repo};

pub async fn create_admin(
    mut db: postgresql::MutDb,
    token: &str,
    admin: &Admin,
) -> Result<i32, String> {
    let user_id = auth::validate_token(token)?;
    let user_access_level = admin_repo::get_admin_access_level(&mut db, user_id).await;
    if admin.access_level > user_access_level.unwrap_or(10) {
        return Err("User access level is not enough".to_string());
    }
    let result = admin_repo::create_admin(db, admin.id.unwrap(), admin.access_level).await;
    match result {
        Ok(admin_id) => Ok(admin_id),
        Err(e) => Err(e.to_string()),
    }
}

pub async fn is_admin(db: &postgresql::MutDb, token: &str) -> Result<bool, String> {
    let user_id = auth::validate_token(token)?;
    let result = admin_repo::is_admin(&db, user_id).await;
    match result {
        Ok(is_admin) => Ok(is_admin),
        Err(e) => Err(e.to_string()),
    }
}
