CREATE TABLE sampled_newly_registered_users (
    wiki_db VARCHAR(255),
    user_id INT(5) UNSIGNED,
    registration_approx VARBINARY(14),
    PRIMARY KEY(wiki_db, user_id)
);
