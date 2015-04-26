SET @date = "20140101";

SELECT SUM(revisions) AS revisions
FROM (
    SELECT
        COUNT(*) AS revisions
    FROM revision
    LEFT JOIN user_groups ON
        rev_user = ug_user AND
        ug_group = "bot"
    WHERE
        rev_timestamp BETWEEN @date AND
            DATE_FORMAT(DATE_ADD(@date, INTERVAL 1 DAY), "%Y%m%d%H%i%S") AND
        rev_user > 0 AND
        ug_group IS NULL
    UNION
    SELECT
        COUNT(*) AS revisions
    FROM archive
    LEFT JOIN user_groups ON
        ar_user = ug_user AND
        ug_group = "bot"
    WHERE
        ar_timestamp BETWEEN @date AND
            DATE_FORMAT(DATE_ADD(@date, INTERVAL 1 DAY), "%Y%m%d%H%i%S") AND
        ar_user > 0 AND
        ug_group IS NULL
) AS table_revisions;
