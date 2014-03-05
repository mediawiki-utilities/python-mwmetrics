SELECT user_activity_months.*, day_revisions FROM new_user_info
INNER JOIN new_user_revisions USING (wiki_db, user_id)
INNER JOIN user_activity_months USING (wiki_db, user_id)
WHERE registration_approx BETWEEN "200101" and "200102"
ORDER BY RAND() 


