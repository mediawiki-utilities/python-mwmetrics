/*DROP TABLE IF EXISTS staging.user_registration_type;*/
CREATE TABLE user_registration_type (
  wiki_db VARCHAR(255),
  user_id INT(5) UNSIGNED,
  user_registration VARBINARY(14),
  registration_type VARCHAR(255),
  PRIMARY KEY(wiki_db, user_id)
)
