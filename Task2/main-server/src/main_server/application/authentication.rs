use hmac::{Hmac, Mac};
use jwt::{SignWithKey, VerifyWithKey};
use pwhash::bcrypt;
use sha2::Sha256;
use std::collections::BTreeMap;

const SECRET: &[u8; 10] = b"secret_key";

fn get_key() -> Hmac<Sha256> {
    Hmac::new_from_slice(SECRET).expect("HMAC can take key of any size")
}

pub fn create_token(user_id: i32) -> String {
    let mut claims = BTreeMap::new();
    claims.insert("user_id", user_id.to_string());
    claims.sign_with_key(&get_key()).unwrap()
}

pub fn validate_token(token: &str) -> Result<i32, String> {
    let claims: BTreeMap<String, String> = token.verify_with_key(&get_key()).unwrap();
    let user_id = claims.get("user_id").ok_or("User id not found")?;
    Ok(user_id.parse().map_err(|_| "User id is not a number")?)
}

pub fn hash_password(password: &str) -> String {
    bcrypt::hash(password).expect("Password hash error")
}

pub fn verify_password(password: &str, hash: &str) -> bool {
    bcrypt::verify(password, hash)
}
