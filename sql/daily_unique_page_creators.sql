SET @date = "20140101";
SET @n = 1;
 
SELECT
    COUNT(*) AS page_creators
FROM (
    SELECT
        rev_user,
        rev_user_text,
        COUNT(*) AS page_creations
    FROM (
        SELECT
            rev_user,
            rev_user_text
        FROM
            revision
        WHERE
            rev_timestamp BETWEEN @date AND
                DATE_FORMAT(DATE_ADD(@date, INTERVAL 1 DAY), "%Y%m%d%H%i%S") AND
            rev_parent_id = 0
        UNION ALL
        SELECT
            ar_user AS rev_user,
            ar_user_text AS rev_user_text
        FROM
            archive
        WHERE
            ar_timestamp BETWEEN @date AND
                DATE_FORMAT(DATE_ADD(@date, INTERVAL 1 DAY), "%Y%m%d%H%i%S") AND
            ar_parent_id = 0
    ) page_creations
) page_creator
WHERE page_creations >= @n;
