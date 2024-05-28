use proc_macro::TokenStream;
use rand::{thread_rng, Rng};

#[proc_macro]
pub fn make_id(_item: TokenStream) -> TokenStream {
    let id = thread_rng().gen_range(1_000_000..9_999_999);
    format!("fn id() -> i32 {{ {} }}", id).parse().unwrap()
}
