pub mod models {
    use std::time::Duration;

    pub struct User<'a> {
        pub id: u32,
        pub email: String,
        pub name: String,
        pub surname: Option<String>,
        pub photo: Option<String>,
        pub birthdate: Option<String>,
        pub personals: Vec<&'a Personal<'a>>,
        pub exercices: Vec<ExerciceUser<'a>>,
        pub rewards: Vec<RewardUser<'a>>,
    }

    struct Personal<'a> {
        id: u32,
        user: User<'a>,
        specification: &'a Specification,
        users: Vec<&'a User<'a>>,
    }

    struct Specification {
        id: u32,
        name: String,
        //    description: String,
    }

    struct Admin<'a> {
        id: u32,
        user: User<'a>,
        access_level: u8,
    }

    struct Exercice<'a> {
        id: u32,
        name: String,
        measurement: String,
        exercice_type: &'a str,
    }

    struct ExerciceUser<'a> {
        id: u32,
        exercice: &'a Exercice<'a>,
        duration: Duration,
        number: u16,
    }

    struct Reward {
        id: u32,
        name: String,
        description: String,
        points: u32,
        condition: dyn Fn(&User) -> bool,
    }

    struct RewardUser<'a> {
        id: i32,
        reward: &'a Reward,
    }

    struct Chat<'a> {
        uuid: String,
        chat_type: &'a str,
        last_message: &'a Message<'a>,
        messages: Vec<Message<'a>>,
    }

    struct Message<'a> {
        id: u32,
        from_user: &'a User<'a>,
        text: String,
    }
}
