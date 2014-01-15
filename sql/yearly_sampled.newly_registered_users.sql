/* 
Results in a sample of newly_registered_users.

Note that users sampled before 2007 are not filtered because the requisite 
logging was not in place at that time. 
*/
    (SELECT
      user_id,
      user_name,
      user_registration
    FROM user
    WHERE user_registration BETWEEN "2001" AND "2002"
    ORDER BY RAND()
    LIMIT 200)
UNION
    (SELECT
      user_id,
      user_name,
      user_registration
    FROM user
    WHERE user_registration BETWEEN "2002" AND "2003"
    ORDER BY RAND()
    LIMIT 200)
UNION
    (SELECT
      user_id,
      user_name,
      user_registration
    FROM user
    WHERE user_registration BETWEEN "2003" AND "2004"
    ORDER BY RAND()
    LIMIT 200)
UNION
    (SELECT
      user_id,
      user_name,
      user_registration
    FROM user
    WHERE user_registration BETWEEN "2004" AND "2005"
    ORDER BY RAND()
    LIMIT 200)
UNION
    (SELECT
      user_id,
      user_name,
      user_registration
    FROM user
    WHERE user_registration BETWEEN "2005" AND "2006"
    ORDER BY RAND()
    LIMIT 200)
UNION
    (SELECT
      user_id,
      user_name,
      user_registration
    FROM user
    WHERE user_registration BETWEEN "2006" AND "2007"
    ORDER BY RAND()
    LIMIT 200)
UNION
    (SELECT
        user_id,
        user_name,
        user_registration
    FROM (
        SELECT log_user AS user_id
        FROM logging 
        WHERE 
            log_type = "newusers" AND 
            log_action = "create" AND
            log_timestamp BETWEEN "2007" AND "2008"
    ) AS newly_registered_users
    INNER JOIN user USING (user_id)
    ORDER BY RAND()
    LIMIT 200)
UNION
    (SELECT
        user_id,
        user_name,
        user_registration
    FROM (
        SELECT log_user AS user_id
        FROM logging 
        WHERE 
            log_type = "newusers" AND 
            log_action = "create" AND
            log_timestamp BETWEEN "2008" AND "2009"
    ) AS newly_registered_users
    INNER JOIN user USING (user_id)
    ORDER BY RAND()
    LIMIT 200)
UNION
    (SELECT
        user_id,
        user_name,
        user_registration
    FROM (
        SELECT log_user AS user_id
        FROM logging 
        WHERE 
            log_type = "newusers" AND 
            log_action = "create" AND
            log_timestamp BETWEEN "2009" AND "2010"
    ) AS newly_registered_users
    INNER JOIN user USING (user_id)
    ORDER BY RAND()
    LIMIT 200)
UNION
    (SELECT
        user_id,
        user_name,
        user_registration
    FROM (
        SELECT log_user AS user_id
        FROM logging 
        WHERE 
            log_type = "newusers" AND 
            log_action = "create" AND
            log_timestamp BETWEEN "2010" AND "2011"
    ) AS newly_registered_users
    INNER JOIN user USING (user_id)
    ORDER BY RAND()
    LIMIT 200)
UNION
    (SELECT
        user_id,
        user_name,
        user_registration
    FROM (
        SELECT log_user AS user_id
        FROM logging 
        WHERE 
            log_type = "newusers" AND 
            log_action = "create" AND
            log_timestamp BETWEEN "2011" AND "2012"
    ) AS newly_registered_users
    INNER JOIN user USING (user_id)
    ORDER BY RAND()
    LIMIT 200)
UNION
    (SELECT
        user_id,
        user_name,
        user_registration
    FROM (
        SELECT log_user AS user_id
        FROM logging 
        WHERE 
            log_type = "newusers" AND 
            log_action = "create" AND
            log_timestamp BETWEEN "2012" AND "2013"
    ) AS newly_registered_users
    INNER JOIN user USING (user_id)
    ORDER BY RAND()
    LIMIT 200)
UNION
    (SELECT
        user_id,
        user_name,
        user_registration
    FROM (
        SELECT log_user AS user_id
        FROM logging 
        WHERE 
            log_type = "newusers" AND 
            log_action = "create" AND
            log_timestamp BETWEEN "2014" AND "2014"
    ) AS newly_registered_users
    INNER JOIN user USING (user_id)
    ORDER BY RAND()
    LIMIT 200);
