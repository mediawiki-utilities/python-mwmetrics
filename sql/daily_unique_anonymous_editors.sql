SET @date = "20140101";
SET @n = 1;

SELECT
    COUNT(*)
FROM (
    SELECT
        rev_user_text,
        SUM(revisions) AS revisions
    FROM (
        SELECT
            rev_user_text,
            COUNT(*) AS revisions
        FROM revision
        WHERE
            rev_timestamp BETWEEN @date AND
                DATE_FORMAT(DATE_ADD(@date, INTERVAL 1 DAY), "%Y%m%d%H%i%S") AND
            rev_user = 0
        GROUP BY 1
        UNION
        SELECT
            ar_user_text AS rev_user_text,
            COUNT(*) AS revisions
        FROM archive
        WHERE
            ar_timestamp BETWEEN @date AND
                DATE_FORMAT(DATE_ADD(@date, INTERVAL 1 DAY), "%Y%m%d%H%i%S") AND
            ar_user = 0
        GROUP BY 1
    ) AS user_revisions
    GROUP BY 1
) AS editors
WHERE revisions >= @n;
