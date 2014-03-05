SELECT
    DATABASE() AS wiki_db,
    user_id,
    MIN(IF(NOT archived, first_edit, NULL)) AS first_revision,
    MIN(IF(archived, first_edit, NULL)) AS first_archived
FROM (
    (SELECT 
        rev_user AS user_id,
        MIN(rev_timestamp) AS first_edit,
        FALSE AS archived
    FROM revision GROUP BY 1)
    UNION
    (SELECT 
        ar_user AS user_id,
        MIN(ar_timestamp) AS first_edit,
        TRUE AS archived
    FROM archive GROUP BY 1)
) AS first_edits
GROUP BY 1,2;




