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
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL UNIQUE,
  access_level INTEGER,
  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_admin_user FOREIGN KEY (user_id) REFERENCES BaseUser(id)
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
  CONSTRAINT fk_rewarduser_user FOREIGN KEY (user_id) REFERENCES BaseUser(id),
  CONSTRAINT fk_rewarduser_reward FOREIGN KEY (reward_id) REFERENCES Reward(id)
);
---- Enumeration for Exercise Type (needs separate table)
--CREATE TABLE ExersiceType (
--  id SMALLINT PRIMARY KEY,
--  name VARCHAR(255) NOT NULL,
--  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--);
---- Exercise table
--CREATE TABLE Exersice (
--  id SERIAL PRIMARY KEY,
--  name VARCHAR(255) NOT NULL,
--  measurement VARCHAR(255),
--  exersice_type_id INTEGER NOT NULL,
--  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--  CONSTRAINT fk_exersice_exercisetype FOREIGN KEY (exersice_type_id) REFERENCES ExersiceType(id)
--);
--
---- ExerciseUser table
--CREATE TABLE ExersiceUser (
--  id SERIAL PRIMARY KEY,
--  exersice_id INTEGER NOT NULL,
--  user_id INTEGER NOT NULL,
--  duration INTEGER,
--  number INTEGER,
--  weight INTEGER,
--  pulse INTEGER,
--  heard_rate INTEGER,
--  create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--  CONSTRAINT fk_exerciseuser_exercise FOREIGN KEY (exersice_id) REFERENCES Exersice(id),
--  CONSTRAINT fk_exerciseuser_user FOREIGN KEY (user_id) REFERENCES BaseUser(id)
--);
--
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
--  CONSTRAINT fk_message_user FOREIGN KEY (from_user_id) REFERENCES BaseUser(id),
--  CONSTRAINT fk_message_chat FOREIGN KEY (chat_id) REFERENCES Chat(uuid)
--);
--
---- UserPersonal table (many-to-many relationship between User and Personal)
--CREATE TABLE UserPersonal (
--  user_id INTEGER NOT NULL,
--  personal_id INTEGER NOT NULL,
--  CONSTRAINT fk_userpersonal_user FOREIGN KEY (user_id) REFERENCES BaseUser(id),
--  CONSTRAINT fk_userpersonal_personal FOREIGN KEY (personal_id) REFERENCES Personal(id),
--  PRIMARY KEY (user_id, personal_id)
--);
--
--
--
---- CREATE TRIGGER update_timestamp BEFORE UPDATE ON BaseUser
----     FOR EACH ROW EXECUTE PROCEDURE moddatetime(update_at);
---- CREATE TRIGGER update_timestamp BEFORE UPDATE ON Personal
----     FOR EACH ROW EXECUTE PROCEDURE moddatetime(update_at);
---- CREATE TRIGGER update_timestamp BEFORE UPDATE ON Admin
----     FOR EACH ROW EXECUTE PROCEDURE moddatetime(update_at);
---- CREATE TRIGGER update_timestamp BEFORE UPDATE ON RewardUser
----     FOR EACH ROW EXECUTE PROCEDURE moddatetime(update_at);
---- CREATE TRIGGER update_timestamp BEFORE UPDATE ON RewardUser
----     FOR EACH ROW EXECUTE PROCEDURE moddatetime(update_at);
