SELECT
    DATABASE() AS wiki_db,
    user_id,
    SUM(revisions_month_1) AS revisions_month_1,
    SUM(revisions_month_2) AS revisions_month_2,
    SUM(revisions_month_3) AS revisions_month_3,
    SUM(revisions_month_4) AS revisions_month_4,
    SUM(revisions_month_5) AS revisions_month_5,
    SUM(revisions_month_6) AS revisions_month_6,
    SUM(revisions_month_7) AS revisions_month_7,
    SUM(revisions_month_8) AS revisions_month_8,
    SUM(revisions_month_9) AS revisions_month_9,
    SUM(revisions_month_10) AS revisions_month_10,
    SUM(revisions_month_11) AS revisions_month_11,
    SUM(revisions_year_1) AS revisions_year_1,
    SUM(revisions_year_2) AS revisions_year_2
FROM (
    (SELECT 
        user_id,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 30*1+1 AND 30*2
        ) AS revisions_month_1,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 30*2+1 AND 30*3
        ) AS revisions_month_2,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 30*3+1 AND 30*4
        ) AS revisions_month_3,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 30*4+1 AND 30*5
        ) AS revisions_month_4,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 30*5+1 AND 30*6
        ) AS revisions_month_5,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 30*6+1 AND 30*7
        ) AS revisions_month_6,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 30*7+1 AND 30*8
        ) AS revisions_month_7,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 30*8+1 AND 30*9
        ) AS revisions_month_8,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 30*9+1 AND 30*10
        ) AS revisions_month_9,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 30*10+1 AND 30*11
        ) AS revisions_month_10,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 30*11+1 AND 365
        ) AS revisions_month_11,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 365*1+1 AND 365*2
        ) AS revisions_year_1,
        SUM(
            rev_timestamp IS NOT NULL AND 
            DATEDIFF(rev_timestamp, user_registration) BETWEEN 365*2+1 AND 365*3
        ) AS revisions_year_2
    FROM user
    LEFT JOIN revision ON 
        rev_user = user_id AND
        rev_timestamp >= DATE_FORMAT(
            DATE_ADD(user_registration, INTERVAL 31 DAY), 
            "%Y%m%d%H%i%S"
        )
    GROUP BY 1)
    UNION
    (SELECT 
        user_id,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 30*1+1 AND 30*2
        ) AS revisions_month_1,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 30*2+1 AND 30*3
        ) AS revisions_month_2,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 30*3+1 AND 30*4
        ) AS revisions_month_3,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 30*4+1 AND 30*5
        ) AS revisions_month_4,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 30*5+1 AND 30*6
        ) AS revisions_month_5,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 30*6+1 AND 30*7
        ) AS revisions_month_6,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 30*7+1 AND 30*8
        ) AS revisions_month_7,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 30*8+1 AND 30*9
        ) AS revisions_month_8,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 30*9+1 AND 30*10
        ) AS revisions_month_9,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 30*10+1 AND 30*11
        ) AS revisions_month_10,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 30*11+1 AND 365
        ) AS revisions_month_11,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 365*1+1 AND 365*2
        ) AS revisions_year_1,
        SUM(
            ar_timestamp IS NOT NULL AND 
            DATEDIFF(ar_timestamp, user_registration) BETWEEN 365*2+1 AND 365*3
        ) AS revisions_year_2
    FROM user
    LEFT JOIN archive ON 
        ar_user = user_id AND
        ar_timestamp >= DATE_FORMAT(
            DATE_ADD(user_registration, INTERVAL 31 DAY), 
            "%Y%m%d%H%i%S"
        )
    GROUP BY 1)
) user_span_revisions
GROUP BY 1,2;
