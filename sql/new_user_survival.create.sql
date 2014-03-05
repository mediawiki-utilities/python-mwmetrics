CREATE TABLE new_user_survival (
    wiki_db VARCHAR(255),
    user_id INT(5) UNSIGNED,
    revisions_3_to_4_weeks INT,
    revisions_1_to_2_months INT,
    revisions_2_to_6_months INT,
    revisions_1_to_2_years INT,
    revisions_1_year_plus_month INT,
    PRIMARY KEY(wiki_db, user_id)
)
