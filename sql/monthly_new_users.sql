SELECT
    DATABASE() AS wiki_db,
    DATE(CONCAT(LEFT(registration_approx, 6), "01")) AS registration_month,
    registration_type,
    SUM(user_id IS NOT NULL) AS registered_users
FROM new_user_info
GROUP BY 1,2,3;
