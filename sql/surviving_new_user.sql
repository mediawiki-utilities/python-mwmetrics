SET @trial_period = 30;
SET @survival_period = 30;
SET @min_edits = 1;
 
SELECT
    user_id,
    surviving_edits > @min_edits AS surviving,
    (
        UNIX_TIMESTAMP(NOW()) - 
        UNIX_TIMESTAMP(DATE_ADD(user_registration, INTERVAL @trial_period+@survival_period DAY))
    ) < 0 AS censored
FROM (
    SELECT
        user_id,
        user_registration,
        IFNULL(COUNT(rev_id), 0) AS surviving_edits
    FROM user
    LEFT JOIN revision ON
        user_id = rev_user AND
        rev_timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @trial_period DAY), "%Y%m%d%H%i%M") AND
            DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @trial_period+@survival_period DAY), "%Y%m%d%H%i%M")
    WHERE user_id IN (16646252)
    GROUP BY user_id, user_registration
) user_surviving_edits;
