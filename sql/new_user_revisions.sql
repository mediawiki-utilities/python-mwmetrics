SELECT
    DATABASE() AS wiki_db,
    user_id,
    SUM(day_revisions) AS day_revisions,
    SUM(day_main_revisions) AS day_main_revisions,
    SUM(week_revisions) AS week_revisions,
    SUM(week_main_revisions) AS week_main_revisions
FROM
    (
        SELECT
            user_id,
            SUM(
                rev_timestamp IS NOT NULL AND 
                rev_timestamp < DATE_FORMAT(
                    DATE_ADD(user_registration, INTERVAL 1 DAY), 
                    "%Y%m%d%H%i%S"
                )
            ) AS day_revisions,
            SUM(
                rev_timestamp IS NOT NULL AND
                rev_timestamp < DATE_FORMAT(
                    DATE_ADD(user_registration, INTERVAL 1 DAY), 
                    "%Y%m%d%H%i%S"
                ) AND page_namespace = 0
            ) AS day_main_revisions,
            SUM(rev_id IS NOT NULL) AS week_revisions,
            SUM(
                page_namespace IS NOT NULL AND 
                page_namespace = 0
            ) AS week_main_revisions
        FROM user
        LEFT JOIN revision ON 
            rev_user = user_id AND
            rev_timestamp <= DATE_FORMAT(
                DATE_ADD(user_registration, INTERVAL 7 DAY), 
                "%Y%m%d%H%i%S"
            )
        LEFT JOIN page ON rev_page = page_id
        GROUP BY 1
    UNION
        SELECT
            user_id,
            SUM(
                rev_timestamp IS NOT NULL AND
                ar_timestamp < DATE_FORMAT(
                    DATE_ADD(user_registration, INTERVAL 1 DAY), 
                    "%Y%m%d%H%i%S"
                )
            ) AS day_revisions,
            SUM(
                rev_timestamp IS NOT NULL AND
                ar_timestamp < DATE_FORMAT(
                    DATE_ADD(user_registration, INTERVAL 1 DAY), 
                    "%Y%m%d%H%i%S"
                ) AND ar_namespace = 0
            ) AS day_main_revisions,
            SUM(ar_id IS NOT NULL) AS week_revisions,
            SUM(
                ar_namespace IS NOT NULL AND 
                ar_namespace = 0
            ) AS week_main_revisions
        FROM user
        LEFT JOIN archive ON 
            ar_user = user_id AND
            ar_timestamp <= DATE_FORMAT(
                DATE_ADD(user_registration, INTERVAL 7 DAY), 
                "%Y%m%d%H%i%S"
            )
        GROUP BY 1
    ) AS user_table_revisions
GROUP BY 1,2;
