/* Results in a complete set of "newly registered users" */
/*DROP TABLE IF EXISTS staging.new_user_info;*/
CREATE TABLE new_user_info (
  wiki_db VARCHAR(255),
  user_id INT(5) UNSIGNED,
  registration_type VARCHAR(5),
  user_registration VARBINARY(14),
  first_edit VARBINARY(14),
  registration_approx VARBINARY(14),
  PRIMARY KEY(wiki_db, user_id)
);

