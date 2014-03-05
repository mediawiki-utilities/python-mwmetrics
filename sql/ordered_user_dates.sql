SELECT 
    DATABASE() AS wiki_db, 
    user.user_id, 
    user.user_registration,
    LEAST(
        IFNULL(MIN(rev_timestamp), MIN(ar_timestamp)),
        IFNULL(MIN(ar_timestamp), MIN(rev_timestamp))
    ) AS first_edit
FROM user
LEFT JOIN revision ON rev_user = user_id
LEFT JOIN archive ON ar_user = user_id
ORDER BY user_id DESC;
