SET @n = 5; /* edits threshold */
SET @u = 30; /* activity unit in days */
SET @T = "20140102"; /* February 1st, 2014 before midnight */
 
/* Results in a set of "new editors" */
SELECT
  user_id,
  user_name,
  user_registration
FROM
  (
    /* Get revisions to content pages that are still visible */
    SELECT
      user_id,
      user_name,
      user_registration,
      SUM(rev_id IS NOT NULL) AS revisions
    FROM user
    INNER JOIN logging ON /* Filter users not created manually */
      log_user = user_id AND
      log_type = "newusers" AND
      log_action = "create"
    LEFT JOIN revision ON
        rev_user = user_id AND
        rev_timestamp <= DATE_FORMAT(
            DATE_ADD(user_registration, INTERVAL @t DAY),
            '%Y%m%d%H%i%S')
    WHERE 
        user_registration BETWEEN DATE_FORMAT(DATE_SUB(@T, INTERVAL @u DAY), "%Y%m%d%H%i%S") AND @T AND
        ar_timestamp BETWEEN DATE_FORMAT(DATE_SUB(@T, INTERVAL @u DAY), "%Y%m%d%H%i%S") AND @T
    GROUP BY 1,2,3
 
    UNION ALL
 
    /* Get revisions to content pages that have been archived */
    SELECT
      user_id,
      user_name,
      user_registration,
      SUM(ar_id IS NOT NULL) AS revisions /* Note that ar_rev_id is sometimes set to NULL :( */
    FROM user
    INNER JOIN logging ON /* Filter users not created manually */
      log_user = user_id AND
      log_type = "newusers" AND
      log_action = "create"
    LEFT JOIN archive ON 
      ar_user = user_id
    WHERE 
        user_registration BETWEEN DATE_FORMAT(DATE_SUB(@T, INTERVAL @u DAY), "%Y%m%d%H%i%S") AND @T AND
        ar_timestamp BETWEEN DATE_FORMAT(DATE_SUB(@T, INTERVAL @u DAY), "%Y%m%d%H%i%S") AND @T
    GROUP BY 1,2,3
  ) AS user_content_revision_count
GROUP BY 1,2,3
HAVING SUM(revisions) >= @n;