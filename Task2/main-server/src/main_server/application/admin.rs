use super::authentication as auth;
use crate::domain::dto::*;
use crate::infrastructure::postgresql;

pub async fn create_admin(
    mut db: postgresql::MutDb,
    token: &str,
    admin: &Admin,
) -> Result<i32, String> {
    let user_id = auth::validate_token(token)?;
    let user_access_level = postgresql::get_admin_access_level(&mut db, user_id).await;
    if admin.access_level > user_access_level.unwrap_or(10) {
        return Err("User access level is not enough".to_string());
    }
    let result = postgresql::create_admin(db, admin.id.unwrap(), admin.access_level).await;
    match result {
        Ok(admin_id) => Ok(admin_id),
        Err(e) => Err(e.to_string()),
    }
}
