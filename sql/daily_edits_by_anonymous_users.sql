SET @date = "20140101";

SELECT
    SUM(revisions) AS revisions
FROM (
    SELECT
        COUNT(*) AS revisions
    FROM revision
    WHERE
        rev_timestamp BETWEEN @date AND
            DATE_FORMAT(DATE_ADD(@date, INTERVAL 1 DAY), "%Y%m%d%H%i%S") AND
        rev_user = 0
    UNION
    SELECT
        COUNT(*) AS revisions
    FROM archive
    WHERE
        ar_timestamp BETWEEN @date AND
            DATE_FORMAT(DATE_ADD(@date, INTERVAL 1 DAY), "%Y%m%d%H%i%S") AND
        ar_user = 0
) AS user_revisions;
