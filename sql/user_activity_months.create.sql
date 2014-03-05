CREATE TABLE user_activity_months (
    wiki_db VARCHAR(255),
    user_id INT(5) UNSIGNED,
    revisions_month_1 INT,
    revisions_month_2 INT,
    revisions_month_3 INT,
    revisions_month_4 INT,
    revisions_month_5 INT,
    revisions_month_6 INT,
    revisions_month_7 INT,
    revisions_month_8 INT,
    revisions_month_9 INT,
    revisions_month_10 INT,
    revisions_month_11 INT,
    revisions_year_1 INT,
    revisions_year_2 INT,
    PRIMARY KEY(wiki_db, user_id)
);
