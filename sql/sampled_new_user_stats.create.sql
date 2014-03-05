CREATE TABLE sampled_new_user_stats (
    wiki_db VARCHAR(255),
    user_id INT(5) UNSIGNED,
    day_revisions INT,
    day_main_revisions INT,
    day_reverted_main_revisions INT,
    week_revisions INT,
    week_main_revisions INT,
    week_reverted_main_revisions INT,
    PRIMARY KEY(wiki_db, user_id)
);
