SELECT
    wiki_db,
    DATE(CONCAT(LEFT(registration_approx, 6), "01")) AS registration_month,
    registration_type,
    SUM(day_revisions >= 1) AS new_editors_day_1,
    SUM(day_revisions >= 1 AND revisions_3_to_4_weeks >= 1) AS surviving_3_to_4_weeks_1,
    SUM(day_revisions >= 1 AND revisions_3_to_4_weeks >= 5) AS surviving_3_to_4_weeks_5,
    SUM(day_revisions >= 1 AND revisions_1_to_2_months >= 1) AS surviving_1_to_2_months_1,
    SUM(day_revisions >= 1 AND revisions_1_to_2_months >= 5) AS surviving_1_to_2_months_5,
    SUM(day_revisions >= 1 AND revisions_2_to_6_months >= 1) AS surviving_2_to_6_months_1,
    SUM(day_revisions >= 1 AND revisions_2_to_6_months >= 5) AS surviving_2_to_6_months_5,
    SUM(day_revisions >= 1 AND revisions_1_to_2_years >= 1) AS surviving_1_to_2_years_1,
    SUM(day_revisions >= 1 AND revisions_1_to_2_years >= 5) AS surviving_1_to_2_years_5,
    SUM(day_revisions >= 1 AND revisions_1_year_plus_month >= 1) AS surviving_1_year_plus_month_1,
    SUM(day_revisions >= 1 AND revisions_1_year_plus_month >= 5) AS surviving_1_year_plus_month_5
FROM new_user_info
LEFT JOIN new_user_survival USING (wiki_db, user_id)
LEFT JOIN new_user_revisions USING (wiki_db, user_id)
GROUP BY 1,2,3;
