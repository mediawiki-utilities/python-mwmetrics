/* 
Results in a sample of new_user_info.

Note that users sampled before 2007 are not filtered because the requisite 
logging was not in place at that time. 
*/
/*********************************** 2001 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200101" AND "200102" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200102" AND "200103" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200103" AND "200104" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200104" AND "200105" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200105" AND "200106" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200107" AND "200108" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200109" AND "200110" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200111" AND "200112" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
/*********************************** 2002 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200201" AND "200202" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200202" AND "200203" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200203" AND "200204" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200204" AND "200205" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200205" AND "200206" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200207" AND "200208" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200209" AND "200210" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200211" AND "200212" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
/*********************************** 2003 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200301" AND "200302" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200302" AND "200303" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200303" AND "200304" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200304" AND "200305" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200305" AND "200306" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200307" AND "200308" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200309" AND "200310" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200311" AND "200312" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
/*********************************** 2004 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200401" AND "200402" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200402" AND "200403" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200403" AND "200404" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200404" AND "200405" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200405" AND "200406" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200407" AND "200408" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200409" AND "200410" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200411" AND "200412" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
/*********************************** 2005 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200501" AND "200502" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200502" AND "200503" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200503" AND "200504" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200504" AND "200505" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200505" AND "200506" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200507" AND "200508" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200509" AND "200510" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200511" AND "200512" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
/*********************************** 2006 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200601" AND "200602" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200602" AND "200603" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200603" AND "200604" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200604" AND "200605" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200605" AND "200606" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200607" AND "200608" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200609" AND "200610" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200611" AND "200612" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
/*********************************** 2007 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200701" AND "200702" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200702" AND "200703" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200703" AND "200704" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200704" AND "200705" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200705" AND "200706" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200707" AND "200708" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200709" AND "200710" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200711" AND "200712" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
/*********************************** 2008 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200801" AND "200802" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200802" AND "200803" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200803" AND "200804" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200804" AND "200805" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200805" AND "200806" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200807" AND "200808" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200809" AND "200810" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200811" AND "200812" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
/*********************************** 2009 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200901" AND "200902" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200902" AND "200903" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200903" AND "200904" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200904" AND "200905" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200905" AND "200906" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200907" AND "200908" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200909" AND "200910" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "200911" AND "200912" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
/*********************************** 2010 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201001" AND "201002" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201002" AND "201003" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201003" AND "201004" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201004" AND "201005" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201005" AND "201006" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201007" AND "201008" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201009" AND "201010" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201011" AND "201012" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
/*********************************** 2011 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201101" AND "201102" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201102" AND "201103" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201103" AND "201104" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201104" AND "201105" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201105" AND "201106" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201107" AND "201108" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201109" AND "201110" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201111" AND "201112" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
/*********************************** 2012 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201201" AND "201202" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201202" AND "201203" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201203" AND "201204" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201204" AND "201205" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201205" AND "201206" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201207" AND "201208" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201209" AND "201210" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201211" AND "201212" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
/*********************************** 2013 *************************************/
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201301" AND "201302" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201302" AND "201303" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201303" AND "201304" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201304" AND "201305" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201305" AND "201306" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201307" AND "201308" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201309" AND "201310" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
UNION
    (SELECT wiki_db, user_id, registration_approx FROM staging.new_user_info
    WHERE registration_approx BETWEEN "201311" AND "201312" AND registration_type = "self" AND wiki_db = @wiki_db
    ORDER BY RAND() LIMIT 300)
