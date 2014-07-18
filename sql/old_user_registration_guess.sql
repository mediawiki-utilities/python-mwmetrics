SET @last_good_user_id = (
    SELECT max(user_id) 
    FROM user_registration_type 
    WHERE 
        wiki_db = @wiki_db AND
        user_registration < "20051226"
);
SELECT
    @wiki_db AS wiki_db,
    user_id,
    user_registration,
    first_revision,
    first_archived
FROM user_registration_type
LEFT JOIN user_first_edit USING (wiki_db, user_id)
WHERE 
    wiki_db = @wiki_db AND
    user_id <= @last_good_user_id
ORDER BY user_id DESC;
