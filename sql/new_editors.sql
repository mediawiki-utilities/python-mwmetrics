
SET @content_namespaces = (0);
SET @t = 1; /* time cutoff in days */
SET @n = 1; /* edits threshold */

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
      IFNULL(
          SUM(page_namespace IN (@content_namespaces)), 
          0
      ) AS content_revisions
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
    LEFT JOIN page ON 
      rev_page = page_id
    GROUP BY 1,2,3
    
    UNION
    
    /* Get revisions to content pages that have been archived */
    SELECT
      user_id,
      user_name,
      user_registration,
      IFNULL(
          SUM(ar_namespace IN (@content_namespaces)), 
          0
      ) AS content_revisions
    FROM user
    INNER JOIN logging ON /* Filter users not created manually */
      log_user = user_id AND
      log_type = "newusers" AND
      log_action = "create"
    LEFT JOIN archive ON 
      ar_user = user_id AND
      ar_timestamp <= DATE_FORMAT(
          DATE_ADD(user_registration, INTERVAL @t DAY),
          '%Y%m%d%H%i%S')
    GROUP BY 1,2,3
  ) AS user_content_revision_count
GROUP BY 1,2,3
HAVING SUM(content_revisions) >= @n;


