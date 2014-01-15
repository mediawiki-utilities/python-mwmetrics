SELECT
    DATABASE() AS wiki,
    DATE(CONCAT(LEFT(IFNULL(approx.user_registration, user.user_registration), 6), "01")) AS registration_month,
    attachment.log_id IS NOT NULL OR by_proxy.log_id IS NOT NULL AS attached,
    SUM(user_id IS NOT NULL) AS registered_users,
    SUM(day_revisions >= 1) AS new_editors_day_1,
    SUM(day_revisions >= 5) AS new_editors_day_5,
    SUM(day_revisions >= 10) AS new_editors_day_10,
    SUM(day_main_revisions >= 1) AS content_editors_day_1,
    SUM(day_main_revisions >= 5) AS content_editors_day_5,
    SUM(day_main_revisions >= 10) AS content_editors_day_10,
    SUM(week_revisions >= 1) AS new_editors_week_1,
    SUM(week_revisions >= 5) AS new_editors_week_5,
    SUM(week_revisions >= 10) AS new_editors_week_10,
    SUM(week_main_revisions >= 1) AS content_editors_week_1,
    SUM(week_main_revisions >= 5) AS content_editors_week_5,
    SUM(week_main_revisions >= 10) AS content_editors_week_10
FROM
    (
        SELECT
            user_id,
            user_name,
            user_registration,
            SUM(day_revisions) AS day_revisions,
            SUM(day_main_revisions) AS day_main_revisions,
            SUM(week_revisions) AS week_revisions,
            SUM(week_main_revisions) AS week_main_revisions
        FROM
            (
                    SELECT
                        user_id,
                        user_name,
                        user_registration,
                        SUM(
                            rev_timestamp < DATE_FORMAT(
                                DATE_ADD(user_registration, INTERVAL 1 DAY), 
                                "%Y%m%d%H%i%S"
                            )
                        ) AS day_revisions,
                        SUM(
                            rev_timestamp < DATE_FORMAT(
                                DATE_ADD(user_registration, INTERVAL 1 DAY), 
                                "%Y%m%d%H%i%S"
                            ) AND page_namespace = 0
                        ) AS day_main_revisions,
                        SUM(rev_id IS NOT NULL) AS week_revisions,
                        SUM(page_namespace = 0) AS week_main_revisions
                    FROM user
                    LEFT JOIN revision ON 
                        rev_user = user_id AND
                        rev_timestamp <= DATE_FORMAT(
                            DATE_ADD(user_registration, INTERVAL 7 DAY), 
                            "%Y%m%d%H%i%S"
                        )
                    LEFT JOIN page ON rev_page = page_id
                    GROUP BY 1,2
                UNION
                    SELECT
                        user_id,
                        user_name,
                        user_registration,
                        SUM(
                            ar_timestamp < DATE_FORMAT(
                                DATE_ADD(user_registration, INTERVAL 1 DAY), 
                                "%Y%m%d%H%i%S"
                            )
                        ) AS day_revisions,
                        SUM(
                            ar_timestamp < DATE_FORMAT(
                                DATE_ADD(user_registration, INTERVAL 1 DAY), 
                                "%Y%m%d%H%i%S"
                            ) AND ar_namespace = 0
                        ) AS day_main_revisions,
                        SUM(ar_id IS NOT NULL) AS week_revisions,
                        SUM(ar_namespace = 0) AS week_main_revisions
                    FROM user
                    LEFT JOIN archive ON 
                        ar_user_text = user_name AND
                        ar_timestamp <= DATE_FORMAT(
                            DATE_ADD(user_registration, INTERVAL 7 DAY), 
                            "%Y%m%d%H%i%S"
                        )
                    GROUP BY 1,2
            ) AS user_table_revisions
        GROUP BY 1,2
    ) AS user
LEFT JOIN logging attachment ON
    attachment.log_timestamp >= "20080522" AND /* First autocreate logged */
    attachment.log_type = "newusers" AND
    attachment.log_action = "autocreate" AND
    attachment.log_user = user_id
LEFT JOIN logging by_proxy ON
    by_proxy.log_timestamp >= "20060419" AND /* First create2 logged */
    by_proxy.log_type = "newusers" AND
    by_proxy.log_action = "create2" AND
    by_proxy.log_title = REPLACE(user_name, " ", "_")
LEFT JOIN user_groups bot_group ON
    ug_user = user_id AND
    ug_group = "bot"
LEFT JOIN staging.approx_registration approx USING(user_id)
WHERE bot_group.ug_group IS NULL
GROUP BY 1,2,3;

