SELECT
    DATABASE() AS wiki,
    day,
    rev_user,
    rev_user_text,
    ug_user IS NOT NULL AS bot_flag,
    SUM(page_creations) AS page_creations,
    SUM(page_creations * archived) AS archived
FROM (
    SELECT
        LEFT(rev_timestamp, 8) AS day,
        rev_user,
        rev_user_text,
        FALSE AS archived,
        COUNT(*) AS page_creations
    FROM
        revision
    WHERE
        rev_parent_id = 0
    GROUP BY 1,2,3,4
    UNION ALL
    SELECT
        LEFT(ar_timestamp, 8) AS day,
        ar_user as rev_user,
        ar_user_text AS rev_user_text,
        TRUE AS archived,
        COUNT(*) AS page_creations
    FROM
        archive
    WHERE
        ar_parent_id = 0
    GROUP BY 1,2,3,4
) AS page_creations_and_archived
LEFT JOIN user_groups ON
    ug_user = rev_user AND
    ug_group = "bot"
GROUP BY 1,2,3,4,5;
