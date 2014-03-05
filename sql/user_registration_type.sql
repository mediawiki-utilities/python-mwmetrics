/* 
Gathers the registration type for all users.  

Users who registered before 
the the way a user registered was consistently logged are assumed to be 
self-created accounts.
*/
SELECT
  DATABASE() AS wiki_db,
  user.user_id,
  user.user_registration,
  IF(bot_group.ug_user IS NOT NULL, "bot",
    IF(proxy.log_id IS NOT NULL, "proxy",
    IF(autocreated.log_id IS NOT NULL, "auto",
        "self"))) AS registration_type
FROM user
LEFT JOIN logging autocreated ON /* Users who are autocreated */
  autocreated.log_user = user_id AND
  autocreated.log_type = "newusers" AND
  autocreated.log_action = "autocreate"
LEFT JOIN logging proxy ON /* Users who were registered by another user */
  proxy.log_title = REPLACE(user_name, " ", "_") AND
  proxy.log_type = "newusers" AND
  proxy.log_action = "create2"
LEFT JOIN user_groups bot_group ON
    ug_user = user_id AND
    ug_group = "bot"
GROUP BY 1,2;
