
SELECT
    day,
    user_text,
    SUM(revisions) AS revisions,
    SUM(revisions * archived) AS archived
FROM (
    SELECT
        LEFT(rev_timestamp, 8) AS day,
        rev_user_text AS user_text,
        COUNT(*) AS revisions,
        FALSE AS archived
    FROM
        revision
    WHERE
        rev_user = 0
    GROUP BY 1,2
    UNION ALL
    SELECT
        LEFT(rev_timestamp, 8) AS day,
        ar_user_text AS user_text,
        COUNT(*) AS revisions,
        TRUE AS archived
    FROM 
        archive
    WHERE
        ar_user = 0
    GROUP BY 1,2
