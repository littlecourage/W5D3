PRAGMA foreign_keys = ON;

DROP TABLE if exists question_likes;
DROP TABLE if exists question_follows;
DROP TABLE if exists replies;
DROP TABLE if exists questions;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);



CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);



CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);



CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    reply_id INTEGER,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (reply_id) REFERENCES replies(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);


CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    like_b INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ("Alvin", "Zablan"),
  ("Jane", "Doe");

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('What to do after a/A?', 'I need some advice about what job to take next.', (SELECT id FROM users WHERE fname = 'Alvin')),
  ('Who murdered me?', 'Please help me find my killer.', (SELECT id FROM users WHERE fname = 'Jane'));

INSERT INTO
  question_follows (user_id, question_id)
VALUES
(
  (SELECT id FROM users WHERE fname = 'Alvin'),
  (SELECT id FROM questions WHERE title = 'What to do after a/A?')
);

INSERT INTO
  replies (body, user_id, reply_id, question_id)
VALUES
    ('I ended up working at Google!', 
    (SELECT id FROM users WHERE fname = 'Alvin'),
    null, (SELECT id FROM questions WHERE title = 'What to do after a/A?')
    );

INSERT INTO
  question_likes (like_b, user_id, question_id)
VALUES
  (1, 
  (SELECT id FROM users WHERE fname = 'Jane'),
  (SELECT id FROM questions WHERE title = 'What to do after a/A?')
  );