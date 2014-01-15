/* Results in a set of "newly registered users" */
SELECT
  user_id,
  user_name,
  user_registration
FROM user
INNER JOIN logging ON /* Filter users not created manually */
  log_user = user_id AND
  log_type = "newusers" AND
  log_action = "create"

