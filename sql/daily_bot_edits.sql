SET @date = "20140101";

SELECT
    SUM(revisions) AS revisions
FROM (
    SELECT
        COUNT(*) AS revisions
    FROM revision
    INNER JOIN user_groups ON
        ug_user = rev_user AND
        ug_group = "bot"
    WHERE
        rev_timestamp BETWEEN @date AND
            DATE_FORMAT(DATE_ADD(@date, INTERVAL 1 DAY), "%Y%m%d%H%i%S") AND
        rev_user > 0
    UNION ALL
    SELECT
        COUNT(*) AS revisions
    FROM archive
    INNER JOIN user_groups ON
        ug_user = ar_user AND
        ug_group = "bot"
    WHERE
        ar_timestamp BETWEEN @date AND
            DATE_FORMAT(DATE_ADD(@date, INTERVAL 1 DAY), "%Y%m%d%H%i%S") AND
        ar_user > 0
) AS bot_user_revisions;
