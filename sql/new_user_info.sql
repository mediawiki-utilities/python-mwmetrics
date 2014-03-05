SELECT
  @wiki_db AS wiki_db,
  user_id,
  registration_type,
  user_registration,
  first_edit.first_edit,
  IFNULL(registration_approx, user_registration) AS registration_approx
FROM staging.user_registration_type reg_type
LEFT JOIN staging.user_first_edit first_edit USING (wiki_db, user_id)
LEFT JOIN staging.user_registration_approx approx USING (wiki_db, user_id)
WHERE wiki_db = @wiki_db
GROUP BY 1,2;
