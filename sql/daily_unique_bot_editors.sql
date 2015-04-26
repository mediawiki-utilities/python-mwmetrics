SET @date = "20140101";
SET @n = 1;

SELECT
    COUNT(*)
FROM (
    SELECT
        rev_user,
        SUM(revisions) AS revisions
    FROM (
        SELECT
            rev_user,
            COUNT(*) AS revisions
        FROM revision
        INNER JOIN user_groups ON
            ug_user = rev_user AND
            ug_group = "bot"
        WHERE
            rev_timestamp BETWEEN @date AND
                DATE_FORMAT(DATE_ADD(@date, INTERVAL 1 DAY), "%Y%m%d%H%i%S") AND
            rev_user > 0
        GROUP BY 1
        UNION ALL
        SELECT
            ar_user AS rev_user,
            COUNT(*) AS revisions
        FROM archive
        INNER JOIN user_groups ON
            ug_user = ar_user AND
            ug_group = "bot"
        WHERE
            ar_timestamp BETWEEN @date AND
                DATE_FORMAT(DATE_ADD(@date, INTERVAL 1 DAY), "%Y%m%d%H%i%S") AND
            ar_user > 0
        GROUP BY 1
    ) AS user_revisions
    GROUP BY 1
) AS editors
WHERE revisions >= @n;
