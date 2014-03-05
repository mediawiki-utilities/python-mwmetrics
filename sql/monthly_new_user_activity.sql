SELECT
    wiki_db,
    DATE(CONCAT(LEFT(registration_approx, 6), "01")) AS registration_month,
    registration_type,
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
FROM new_user_info
LEFT JOIN new_user_revisions USING (wiki_db, user_id)
GROUP BY 1,2,3;
