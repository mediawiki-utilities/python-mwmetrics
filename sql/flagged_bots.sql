INSERT INTO staging.flagged_bots
SELECT DATABASE(), ug_user
FROM user_groups
WHERE ug_group = "bot";
