CREATE TABLE user_first_edit (
    wiki_db VARCHAR(255),
    user_id INT(5) UNSIGNED,
    first_revision VARBINARY(14),
    first_archived VARBINARY(14),
    PRIMARY KEY(wiki_db, user_id)
);
