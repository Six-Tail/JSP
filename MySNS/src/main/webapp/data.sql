USE mysns1;

INSERT INTO user VALUES("KimSimin", "111", "김시민", now(), "01012345678", "kim@abc.com");
INSERT INTO user VALUES("YiSunsin", "111", "이순신", now(), "01012123434", "lee@abc.com");
INSERT INTO user VALUES("KwonYul", "111", "권율", now(), "01011112222", "kwon@abc.com");

INSERT INTO feed(id, content) VALUES("KimSimin", "Hello");
INSERT INTO feed(id, content) VALUES("KwonYul", "Aloha");

--ALTER TABLE user
--ADD COLUMN phone_number varchar(20) DEFAULT NULL,
--ADD COLUMN email varchar(50) DEFAULT NULL;