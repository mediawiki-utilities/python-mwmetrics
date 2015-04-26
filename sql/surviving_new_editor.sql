SET @activation_period = 1;
SET @trial_period = 30;
SET @survival_period = 30;

SELECT
    user_id,
    SUM(activation_edits) > 0 AS activated,
    SUM(activation_edits) > 0 AND SUM(surviving_edits) > 0 AS surviving,
    (
        UNIX_TIMESTAMP(NOW()) - 
        UNIX_TIMESTAMP(DATE_ADD(user_registration, INTERVAL @trial_period+@survival_period DAY))
    ) < 0 AS censored
FROM (
    SELECT
        user_id,
        user_registration,
        SUM(
            rev_timestamp BETWEEN
                user_registration AND
                DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @activation_period DAY), "%Y%m%d%H%i%M")
        ) AS activation_edits,
        SUM(
            rev_timestamp BETWEEN
                DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @trial_period DAY), "%Y%m%d%H%i%M") AND
                DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @trial_period+@survival_period DAY), "%Y%m%d%H%i%M")
        ) AS surviving_edits
    FROM user
    LEFT JOIN revision ON
        user_id = rev_user AND
        (
            rev_timestamp BETWEEN
                user_registration AND
                DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @activation_period DAY), "%Y%m%d%H%i%M") OR 
            rev_timestamp BETWEEN
                DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @trial_period DAY), "%Y%m%d%H%i%M") AND
                DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @trial_period+@survival_period DAY), "%Y%m%d%H%i%M")
        )
    WHERE user_id IN (16646252)
    UNION
    SELECT
        user_id,
        user_registration,
        SUM(
            ar_timestamp BETWEEN
                user_registration AND
                DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @activation_period DAY), "%Y%m%d%H%i%M")
        ) AS activation_edits,
        SUM(
            ar_timestamp BETWEEN
                DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @trial_period DAY), "%Y%m%d%H%i%M") AND
                DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @trial_period+@survival_period DAY), "%Y%m%d%H%i%M")
        ) AS surviving_edits
    FROM user
    LEFT JOIN archive ON
        user_id = ar_user AND
        (
            ar_timestamp BETWEEN
                user_registration AND
                DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @activation_period DAY), "%Y%m%d%H%i%M") OR 
            ar_timestamp BETWEEN
                DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @trial_period DAY), "%Y%m%d%H%i%M") AND
                DATE_FORMAT(DATE_ADD(user_registration, INTERVAL @trial_period+@survival_period DAY), "%Y%m%d%H%i%M")
        )
    WHERE user_id IN (16646252)
) split_edit_counts
GROUP BY user_id, user_registration;
