-- User table
CREATE TABLE user_base (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  surname VARCHAR(255),
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  photo VARCHAR(255),
  birthday DATE,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- Personal table
CREATE TABLE personal (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL UNIQUE,
  specification_id INTEGER,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_user_personal FOREIGN KEY (user_id) REFERENCES user_base(id)
);

-- Specification table
CREATE TABLE specification (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

-- Admin table (inherits from User)
CREATE TABLE admin (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL UNIQUE,
  access_level INTEGER,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_admin_user FOREIGN KEY (user_id) REFERENCES user_base(id)
);

-- Reward table
CREATE TABLE reward (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  condition TEXT NOT NULL,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- RewardUser table
CREATE TABLE reward_user(
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  reward_id INTEGER NOT NULL,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_rewarduser_user FOREIGN KEY (user_id) REFERENCES user_base(id),
  CONSTRAINT fk_rewarduser_reward FOREIGN KEY (reward_id) REFERENCES Reward(id)
);
-- Enumeration for Exercise Type (needs separate table)
CREATE TABLE exercice_type (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- Exercise table
CREATE TABLE exercice (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  measurement VARCHAR(255),
  exercice_type_id INTEGER NOT NULL,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_exercice_exercisetype FOREIGN KEY (exercice_type_id) REFERENCES exercice_type(id)
);

-- ExerciseUser table
CREATE TABLE exercice_user (
  id SERIAL PRIMARY KEY,
  exercice_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  duration INTEGER DEFAULT NULL,
  number INTEGER DEFAULT NULL,
  weight INTEGER DEFAULT NULL,
  pulse INTEGER DEFAULT NULL,
  heard_rate INTEGER DEFAULT NULL,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_exerciseuser_exercise FOREIGN KEY (exercice_id) REFERENCES Exercice(id),
  CONSTRAINT fk_exerciseuser_user FOREIGN KEY (user_id) REFERENCES user_base(id)
);

CREATE TABLE iot_user (
    id SERIAL PRIMARY KEY,
    user_id INTEGER DEFAULT NULL,
    next_exercise_id INTEGER DEFAULT NULL,
    create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_iot_user FOREIGN KEY (user_id) REFERENCES user_base(id),
    CONSTRAINT fk_iot_exercise FOREIGN KEY (next_exercise_id) REFERENCES exercice_user(id)
);

INSERT INTO user_base(name, surname, email, password_hash) VALUES ('admin', 'admin', 'sss', '$2b$10$7614Rt0Wieb/hPEPyMpJheTDYaSYVQ/R6cgch2wqKePaJp/T/BlE.');
INSERT INTO admin(user_id, access_level) VALUES (1, 10);

INSERT INTO specification(name) VALUES ('Personal Trainer');
INSERT INTO specification(name) VALUES ('Nutritionist');

INSERT INTO exercice_type(name) VALUES ('Cardio');
INSERT INTO exercice_type(name) VALUES ('Strength');

INSERT INTO exercice(name, measurement, exercice_type_id) VALUES ('Running', 'km', 1);
INSERT INTO exercice(name, measurement, exercice_type_id) VALUES ('Cycling', 'km', 1);
INSERT INTO exercice(name, measurement, exercice_type_id) VALUES ('Swimming', 'km', 1);
INSERT INTO exercice(name, measurement, exercice_type_id) VALUES ('Squats', 'reps', 2);

INSERT INTO reward(name, condition) VALUES ('First reward', 'First reward condition');
INSERT INTO reward(name, condition) VALUES ('Second reward', 'Second reward condition');


INSERT INTO user_base(name, email, password_hash) VALUES ('personal', 'personal', '$2b$10$7614Rt0Wieb/hPEPyMpJheTDYaSYVQ/R6cgch2wqKePaJp/T/BlE.');
INSERT INTO personal(user_id, specification_id) VALUES (2, 1);
INSERT INTO reward_user(user_id, reward_id) VALUES (2, 1);
INSERT INTO reward_user(user_id, reward_id) VALUES (2, 2);
INSERT INTO exercice_user(exercice_id, user_id, duration, number, weight, pulse, heard_rate) VALUES (1, 2, 10, 10, 10, 10, 10);
INSERT INTO exercice_user(exercice_id, user_id, duration, number, weight, pulse, heard_rate) VALUES (2, 2, 10, 10, 10, 10, 10);



--
--
--CREATE TYPE ChatType AS ENUM ('private', 'group', 'channel');
--
---- Chat table
--CREATE TABLE Chat (
--  uuid UUID PRIMARY KEY,
--  type ChatType NOT NULL,
--  name VARCHAR(255),
--  last_message VARCHAR(255),
--  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--  update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--);
--
---- Message table
--CREATE TABLE Message (
--  id SERIAL PRIMARY KEY,
--  from_user_id INTEGER NOT NULL,
--  chat_id UUID NOT NULL,
--  text TEXT NOT NULL,
--  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--  CONSTRAINT fk_message_user FOREIGN KEY (from_user_id) REFERENCES user_base(id),
--  CONSTRAINT fk_message_chat FOREIGN KEY (chat_id) REFERENCES Chat(uuid)
--);
--
---- UserPersonal table (many-to-many relationship between User and Personal)
--CREATE TABLE UserPersonal (
--  user_id INTEGER NOT NULL,
--  personal_id INTEGER NOT NULL,
--  CONSTRAINT fk_userpersonal_user FOREIGN KEY (user_id) REFERENCES user_base(id),
--  CONSTRAINT fk_userpersonal_personal FOREIGN KEY (personal_id) REFERENCES Personal(id),
--  PRIMARY KEY (user_id, personal_id)
--);
--
--
--
---- CREATE TRIGGER update_timestamp BEFORE UPDATE ON user_base
----     FOR EACH ROW EXECUTE PROCEDURE moddatetime(update_at);
---- CREATE TRIGGER update_timestamp BEFORE UPDATE ON Personal
----     FOR EACH ROW EXECUTE PROCEDURE moddatetime(update_at);
---- CREATE TRIGGER update_timestamp BEFORE UPDATE ON Admin
----     FOR EACH ROW EXECUTE PROCEDURE moddatetime(update_at);
---- CREATE TRIGGER update_timestamp BEFORE UPDATE ON RewardUser
----     FOR EACH ROW EXECUTE PROCEDURE moddatetime(update_at);
---- CREATE TRIGGER update_timestamp BEFORE UPDATE ON RewardUser
----     FOR EACH ROW EXECUTE PROCEDURE moddatetime(update_at);
