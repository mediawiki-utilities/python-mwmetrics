SELECT
    wiki,
    day,
    SUM(revisions >= 1) AS revs_gte_1,
    SUM(revisions >= 1 AND bot.user_id IS NULL) AS revs_gte_1_no_bot,
    SUM(revisions - archived >= 1) AS revs_no_arch_gte_1,
    SUM(revisions - archived >= 1 AND
        bot.user_id IS NULL) AS revs_no_arch_gte_1_no_bot,
    SUM(revisions >= 5) AS revs_gte_5,
    SUM(revisions >= 5 AND bot.user_id IS NULL) AS revs_gte_5_no_bot,
    SUM(revisions - archived >= 5) AS revs_no_arch_gte_5,
    SUM(revisions - archived >= 5 AND
        bot.user_id IS NULL) AS revs_no_arch_gte_5_no_bot
FROM editor_day
LEFT JOIN flagged_bot bot USING (wiki, user_id)
GROUP BY 1,2;
