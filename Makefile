################################################################################
#                              Variables
################################################################################
slavedb = analytics-slave.eqiad.wmnet
enwiki = --defaults-file=~/.my.research.cnf -h s1-$(slavedb) -u research enwiki
dewiki = --defaults-file=~/.my.research.cnf -h s5-$(slavedb) -u research dewiki
eswiki = --defaults-file=~/.my.research.cnf -h s7-$(slavedb) -u research eswiki
ptwiki = --defaults-file=~/.my.research.cnf -h s2-$(slavedb) -u research ptwiki
plwiki = --defaults-file=~/.my.research.cnf -h s2-$(slavedb) -u research plwiki
frwiki = --defaults-file=~/.my.research.cnf -h s6-$(slavedb) -u research frwiki
ruwiki = --defaults-file=~/.my.research.cnf -h s6-$(slavedb) -u research ruwiki
staging = --defaults-file=~/.my.halfak.cnf -h db1047.eqiad.wmnet staging

.PHONY = datasets/monthly_user_counts.tsv \
         datasets/sampled_newly_registered_users.tsv \
         datasets/sampled_new_user_stats.tsv


################################################################################
########################### Aggregated datasets ################################
################################################################################
datasets/monthly_new_user_survival.tsv: sql/monthly_new_user_survival.sql \
                            datasets/staging/new_user_info.table \
                            datasets/staging/new_user_survival.table \
                            datasets/staging/new_user_revisions.table
	cat sql/monthly_new_user_survival.sql | \
	mysql $(staging) > \
	datasets/monthly_new_user_survival.tsv

datasets/monthly_new_user_activity.tsv: sql/monthly_new_user_activity.sql \
                            datasets/staging/new_user_info.table \
                            datasets/staging/new_user_revisions.table
	cat sql/monthly_new_user_activity.sql | \
	mysql $(staging) > \
	datasets/monthly_new_user_activity.tsv

datasets/sampled_newly_registered_users.tsv: datasets/staging/sampled_newly_registered_users.table
	mysql $(staging) -e "SELECT * FROM sampled_newly_registered_users;" > \
	datasets/sampled_newly_registered_users.tsv
	
datasets/sampled_new_user_stats.tsv: datasets/staging/sampled_new_user_stats.table
	mysql $(staging) -e "SELECT * FROM sampled_new_user_stats;" > \
	datasets/sampled_new_user_stats.tsv

################################################################################
############################# Create tables ####################################
################################################################################
datasets/staging/user_activity_months.table: sql/user_activity_months.create.sql
	cat sql/user_activity_months.create.sql | \
	mysql $(staging) > datasets/staging/user_activity_months.table

datasets/staging/new_user_survival.table: sql/new_user_survival.create.sql
	cat sql/new_user_survival.create.sql | \
	mysql $(staging) > datasets/staging/new_user_survival.table
	
datasets/staging/new_user_revisions.table: sql/new_user_revisions.create.sql
	cat sql/new_user_revisions.create.sql | \
	mysql $(staging) > datasets/staging/new_user_revisions.table

datasets/staging/new_user_info.table: sql/new_user_info.create.sql
	cat sql/new_user_info.create.sql | \
	mysql $(staging) > datasets/staging/new_user_info.table

datasets/staging/user_registration_type.table: sql/user_registration_type.create.sql
	cat sql/user_registration_type.create.sql | \
	mysql $(staging) > datasets/staging/user_registration_type.table

datasets/staging/user_registration_approx.table: sql/user_registration_approx.create.sql
	cat sql/user_registration_approx.create.sql | \
	mysql $(staging) > datasets/staging/user_registration_approx.table

datasets/staging/user_first_edit.table: sql/user_first_edit.create.sql
	cat sql/user_first_edit.create.sql | \
	mysql $(staging) > datasets/staging/user_first_edit.table

datasets/staging/sampled_newly_registered_users.table: sql/sampled_newly_registered_users.create.sql
	cat sql/sampled_newly_registered_users.create.sql | \
	mysql $(staging) > datasets/staging/sampled_newly_registered_users.table

datasets/staging/sampled_new_user_stats.table: sql/sampled_new_user_stats.create.sql
	cat sql/sampled_new_user_stats.create.sql | \
	mysql $(staging) > datasets/staging/sampled_new_user_stats.table


################################################################################
################################ Languages #####################################
################################################################################


                               #############
                              ##  English  ##
################################################################################

####### user_activity_months
datasets/enwiki/user_activity_months.table: datasets/enwiki/user_activity_months.no_header.tsv \
                                         datasets/staging/user_activity_months.table
	
	mysql $(staging) -e "DELETE FROM user_activity_months WHERE wiki_db = 'enwiki';" && \
	ln -s -f user_activity_months.no_header.tsv datasets/enwiki/user_activity_months && \
	mysqlimport $(staging) --local datasets/enwiki/user_activity_months && \
	rm -f datasets/enwiki/user_activity_months && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_activity_months WHERE wiki_db = 'enwiki';" > \
	datasets/enwiki/user_activity_months.table
	
datasets/enwiki/user_activity_months.no_header.tsv: sql/user_activity_months.sql
	cat sql/user_activity_months.sql | \
	mysql $(enwiki) -N > \
	datasets/enwiki/user_activity_months.no_header.tsv

####### new_user_survival
datasets/enwiki/new_user_survival.table: datasets/enwiki/new_user_survival.no_header.tsv \
                                         datasets/staging/new_user_survival.table
	
	mysql $(staging) -e "DELETE FROM new_user_survival WHERE wiki_db = 'enwiki';" && \
	ln -s -f new_user_survival.no_header.tsv datasets/enwiki/new_user_survival && \
	mysqlimport $(staging) --local datasets/enwiki/new_user_survival && \
	rm -f datasets/enwiki/new_user_survival && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_survival WHERE wiki_db = 'enwiki';" > \
	datasets/enwiki/new_user_survival.table
	
datasets/enwiki/new_user_survival.no_header.tsv: sql/new_user_survival.sql
	cat sql/new_user_survival.sql | \
	mysql $(enwiki) -N > \
	datasets/enwiki/new_user_survival.no_header.tsv

####### new_user_revisions
datasets/enwiki/new_user_revisions.table: datasets/enwiki/new_user_revisions.no_header.tsv \
                                          datasets/staging/new_user_revisions.table
	
	mysql $(staging) -e "DELETE FROM new_user_revisions WHERE wiki_db = 'enwiki';" && \
	ln -s -f new_user_revisions.no_header.tsv datasets/enwiki/new_user_revisions && \
	mysqlimport $(staging) --local datasets/enwiki/new_user_revisions && \
	rm -f datasets/enwiki/new_user_revisions && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_revisions WHERE wiki_db = 'enwiki';" > \
	datasets/enwiki/new_user_revisions.table
	
datasets/enwiki/new_user_revisions.no_header.tsv: sql/new_user_revisions.sql
	cat sql/new_user_revisions.sql | \
	mysql $(enwiki) -N > \
	datasets/enwiki/new_user_revisions.no_header.tsv

####### new_user_info
datasets/enwiki/new_user_info.table: datasets/enwiki/new_user_info.no_header.tsv \
                                     datasets/staging/new_user_info.table
	
	mysql $(staging) -e "DELETE FROM new_user_info WHERE wiki_db = 'enwiki';" && \
	ln -s -f new_user_info.no_header.tsv datasets/enwiki/new_user_info && \
	mysqlimport $(staging) --local datasets/enwiki/new_user_info && \
	rm -f datasets/enwiki/new_user_info && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_info WHERE wiki_db = 'enwiki';" > \
	datasets/enwiki/new_user_info.table
	
datasets/enwiki/new_user_info.no_header.tsv: sql/new_user_info.sql \
                                              datasets/enwiki/user_registration_type.table \
                                              datasets/enwiki/user_registration_approx.table
	echo "SET @wiki_db = 'enwiki';" | \
	cat - sql/new_user_info.sql | \
	mysql $(staging) -N > \
	datasets/enwiki/new_user_info.no_header.tsv

####### user_registration_type
datasets/enwiki/user_registration_type.table: datasets/enwiki/user_registration_type.no_header.tsv \
                                              datasets/staging/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_type WHERE wiki_db = 'enwiki';" && \
	ln -s -f user_registration_type.no_header.tsv datasets/enwiki/user_registration_type && \
	mysqlimport $(staging) --local datasets/enwiki/user_registration_type && \
	rm -f datasets/enwiki/user_registration_type && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_type WHERE wiki_db = 'enwiki';" > \
	datasets/enwiki/user_registration_type.table
	
datasets/enwiki/user_registration_type.no_header.tsv: sql/user_registration_type.sql
	cat sql/user_registration_type.sql | \
	mysql $(enwiki) -N > \
	datasets/enwiki/user_registration_type.no_header.tsv

####### user_first_edit
datasets/enwiki/user_first_edit.table: datasets/enwiki/user_first_edit.no_header.tsv \
                                       datasets/staging/user_first_edit.table
	mysql $(staging) -e "DELETE FROM user_first_edit WHERE wiki_db = 'enwiki';" && \
	ln -s -f user_first_edit.no_header.tsv datasets/enwiki/user_first_edit && \
	mysqlimport $(staging) --local  datasets/enwiki/user_first_edit && \
	rm -f datasets/enwiki/user_first_edit && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_first_edit WHERE wiki_db = 'enwiki';" > \
	datasets/enwiki/user_first_edit.table
	
datasets/enwiki/user_first_edit.no_header.tsv: sql/user_first_edit.sql
	cat sql/user_first_edit.sql | \
	mysql $(enwiki) -N > \
	datasets/enwiki/user_first_edit.no_header.tsv
	
####### user_registration_approx
datasets/enwiki/user_registration_approx.table: datasets/enwiki/user_registration_approx.no_header.tsv \
                                                datasets/enwiki/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_approx WHERE wiki_db = 'enwiki';" && \
	ln -s -f user_registration_approx.no_header.tsv datasets/enwiki/user_registration_approx && \
	mysqlimport $(staging) --local  datasets/enwiki/user_registration_approx && \
	rm -f datasets/enwiki/user_registration_approx && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_approx WHERE wiki_db = 'enwiki';" > \
	datasets/enwiki/user_registration_approx.table
	
datasets/enwiki/user_registration_approx.no_header.tsv: sql/old_user_registration_guess.sql \
                                                        datasets/enwiki/user_first_edit.table
	echo "SET @wiki_db = 'enwiki';" | \
	cat - sql/old_user_registration_guess.sql | \
	mysql $(staging) | \
	./user_registration_approx --no-header > \
	datasets/enwiki/user_registration_approx.no_header.tsv

####### sampled_newly_registered_users
datasets/enwiki/sampled_newly_registered_users.no_header.tsv: sql/sampled_newly_registered_users.sql \
                                                               datasets/enwiki/new_user_info.table
	echo "SET @wiki_db = 'enwiki';" | \
	cat - sql/sampled_newly_registered_users.sql | \
	mysql $(staging) > \
	datasets/enwiki/sampled_newly_registered_users.no_header.tsv
	
datasets/enwiki/sampled_newly_registered_users.table: datasets/enwiki/sampled_newly_registered_users.no_header.tsv \
                                                      datasets/staging/sampled_newly_registered_users.table
	mysql $(staging) -e "DELETE FROM sampled_newly_registered_users WHERE wiki_db = 'enwiki';" && \
	ln -s -f sampled_newly_registered_users.no_header.tsv datasets/enwiki/sampled_newly_registered_users && \
	mysqlimport $(staging) --local  datasets/enwiki/sampled_newly_registered_users && \
	rm -f datasets/enwiki/sampled_newly_registered_users && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_newly_registered_users WHERE wiki_db = 'enwiki';" > \
	datasets/enwiki/sampled_newly_registered_users.table
	
####### sampled_new_user_stats
datasets/enwiki/sampled_new_user_stats.no_header.tsv: datasets/enwiki/sampled_newly_registered_users.table \
                                                      metrics/new_user_stats.py
	mysql $(staging) -e "SELECT * FROM sampled_newly_registered_users WHERE wiki_db = 'enwiki';" | \
	./new_user_stats --no-headers > \
	datasets/enwiki/sampled_new_user_stats.no_header.tsv

datasets/enwiki/sampled_new_user_stats.table: datasets/enwiki/sampled_new_user_stats.no_header.tsv \
                                              datasets/staging/sampled_new_user_stats.table
	mysql $(staging) -e "DELETE FROM sampled_new_user_stats WHERE wiki_db = 'enwiki';" && \
	ln -s -f sampled_new_user_stats.no_header.tsv datasets/enwiki/sampled_new_user_stats && \
	mysqlimport $(staging) --local  datasets/enwiki/sampled_new_user_stats && \
	rm -f datasets/enwiki/sampled_new_user_stats && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_new_user_stats WHERE wiki_db = 'enwiki';" > \
	datasets/enwiki/sampled_new_user_stats.table



                                ##########
                               ## German ##
################################################################################


####### user_activity_months
datasets/dewiki/user_activity_months.table: datasets/dewiki/user_activity_months.no_header.tsv \
                                         datasets/staging/user_activity_months.table
	
	mysql $(staging) -e "DELETE FROM user_activity_months WHERE wiki_db = 'dewiki';" && \
	ln -s -f user_activity_months.no_header.tsv datasets/dewiki/user_activity_months && \
	mysqlimport $(staging) --local datasets/dewiki/user_activity_months && \
	rm -f datasets/dewiki/user_activity_months && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_activity_months WHERE wiki_db = 'dewiki';" > \
	datasets/dewiki/user_activity_months.table
	
datasets/dewiki/user_activity_months.no_header.tsv: sql/user_activity_months.sql
	cat sql/user_activity_months.sql | \
	mysql $(dewiki) -N > \
	datasets/dewiki/user_activity_months.no_header.tsv
	

####### new_user_survival
datasets/dewiki/new_user_survival.table: datasets/dewiki/new_user_survival.no_header.tsv \
                                         datasets/staging/new_user_survival.table
	
	mysql $(staging) -e "DELETE FROM new_user_survival WHERE wiki_db = 'dewiki';" && \
	ln -s -f new_user_survival.no_header.tsv datasets/dewiki/new_user_survival && \
	mysqlimport $(staging) --local datasets/dewiki/new_user_survival && \
	rm -f datasets/dewiki/new_user_survival && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_survival WHERE wiki_db = 'dewiki';" > \
	datasets/dewiki/new_user_survival.table
	
datasets/dewiki/new_user_survival.no_header.tsv: sql/new_user_survival.sql
	cat sql/new_user_survival.sql | \
	mysql $(dewiki) -N > \
	datasets/dewiki/new_user_survival.no_header.tsv


####### new_user_revisions
datasets/dewiki/new_user_revisions.table: datasets/dewiki/new_user_revisions.no_header.tsv \
                                          datasets/staging/new_user_revisions.table
	
	mysql $(staging) -e "DELETE FROM new_user_revisions WHERE wiki_db = 'dewiki';" && \
	ln -s -f new_user_revisions.no_header.tsv datasets/dewiki/new_user_revisions && \
	mysqlimport $(staging) --local datasets/dewiki/new_user_revisions && \
	rm -f datasets/dewiki/new_user_revisions && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_revisions WHERE wiki_db = 'dewiki';" > \
	datasets/dewiki/new_user_revisions.table
	
datasets/dewiki/new_user_revisions.no_header.tsv: sql/new_user_revisions.sql
	cat sql/new_user_revisions.sql | \
	mysql $(dewiki) -N > \
	datasets/dewiki/new_user_revisions.no_header.tsv

####### new_user_info
datasets/dewiki/new_user_info.table: datasets/dewiki/new_user_info.no_header.tsv \
                                     datasets/staging/new_user_info.table
	
	mysql $(staging) -e "DELETE FROM new_user_info WHERE wiki_db = 'dewiki';" && \
	ln -s -f new_user_info.no_header.tsv datasets/dewiki/new_user_info && \
	mysqlimport $(staging) --local datasets/dewiki/new_user_info && \
	rm -f datasets/dewiki/new_user_info && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_info WHERE wiki_db = 'dewiki';" > \
	datasets/dewiki/new_user_info.table
	
datasets/dewiki/new_user_info.no_header.tsv: sql/new_user_info.sql \
                                              datasets/dewiki/user_registration_type.table \
                                              datasets/dewiki/user_registration_approx.table
	echo "SET @wiki_db = 'dewiki';" | \
	cat - sql/new_user_info.sql | \
	mysql $(staging) -N > \
	datasets/dewiki/new_user_info.no_header.tsv

####### user_registration_type
datasets/dewiki/user_registration_type.table: datasets/dewiki/user_registration_type.no_header.tsv \
                                              datasets/staging/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_type WHERE wiki_db = 'dewiki';" && \
	ln -s -f user_registration_type.no_header.tsv datasets/dewiki/user_registration_type && \
	mysqlimport $(staging) --local datasets/dewiki/user_registration_type && \
	rm -f datasets/dewiki/user_registration_type && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_type WHERE wiki_db = 'dewiki';" > \
	datasets/dewiki/user_registration_type.table
	
datasets/dewiki/user_registration_type.no_header.tsv: sql/user_registration_type.sql
	cat sql/user_registration_type.sql | \
	mysql $(dewiki) -N > \
	datasets/dewiki/user_registration_type.no_header.tsv

####### user_first_edit
datasets/dewiki/user_first_edit.table: datasets/dewiki/user_first_edit.no_header.tsv \
                                       datasets/staging/user_first_edit.table
	mysql $(staging) -e "DELETE FROM user_first_edit WHERE wiki_db = 'dewiki';" && \
	ln -s -f user_first_edit.no_header.tsv datasets/dewiki/user_first_edit && \
	mysqlimport $(staging) --local datasets/dewiki/user_first_edit && \
	rm -f datasets/dewiki/user_first_edit && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_first_edit WHERE wiki_db = 'dewiki';" > \
	datasets/dewiki/user_first_edit.table
	
datasets/dewiki/user_first_edit.no_header.tsv: sql/user_first_edit.sql
	cat sql/user_first_edit.sql | \
	mysql $(dewiki) -N > \
	datasets/dewiki/user_first_edit.no_header.tsv
	
####### user_registration_approx
datasets/dewiki/user_registration_approx.table: datasets/dewiki/user_registration_approx.no_header.tsv \
                                                datasets/dewiki/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_approx WHERE wiki_db = 'dewiki';" && \
	ln -s -f user_registration_approx.no_header.tsv datasets/dewiki/user_registration_approx && \
	mysqlimport $(staging) --local datasets/dewiki/user_registration_approx && \
	rm -f datasets/dewiki/user_registration_approx && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_approx WHERE wiki_db = 'dewiki';" > \
	datasets/dewiki/user_registration_approx.table
	
datasets/dewiki/user_registration_approx.no_header.tsv: sql/old_user_registration_guess.sql \
                                                        datasets/dewiki/user_first_edit.table
	echo "SET @wiki_db = 'dewiki';" | \
	cat - sql/old_user_registration_guess.sql | \
	mysql $(staging) | \
	./user_registration_approx --no-header > \
	datasets/dewiki/user_registration_approx.no_header.tsv

####### sampled_newly_registered_users
datasets/dewiki/sampled_newly_registered_users.no_header.tsv: sql/sampled_newly_registered_users.sql \
                                                               datasets/dewiki/new_user_info.table
	echo "SET @wiki_db = 'dewiki';" | \
	cat - sql/sampled_newly_registered_users.sql | \
	mysql $(staging) > \
	datasets/dewiki/sampled_newly_registered_users.no_header.tsv
	
datasets/dewiki/sampled_newly_registered_users.table: datasets/dewiki/sampled_newly_registered_users.no_header.tsv \
                                                      datasets/staging/sampled_newly_registered_users.table
	mysql $(staging) -e "DELETE FROM sampled_newly_registered_users WHERE wiki_db = 'dewiki';" && \
	ln -s -f sampled_newly_registered_users.no_header.tsv datasets/dewiki/sampled_newly_registered_users && \
	mysqlimport $(staging) --local datasets/dewiki/sampled_newly_registered_users && \
	rm -f datasets/dewiki/sampled_newly_registered_users && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_newly_registered_users WHERE wiki_db = 'dewiki';" > \
	datasets/dewiki/sampled_newly_registered_users.table
	
####### sampled_new_user_stats
datasets/dewiki/sampled_new_user_stats.no_header.tsv: datasets/dewiki/sampled_newly_registered_users.table \
                                                      metrics/new_user_stats.py
	mysql $(staging) -e "SELECT * FROM sampled_newly_registered_users WHERE wiki_db = 'dewiki';" | \
	./new_user_stats --no-headers -h s5-analytics-slave.eqiad.wmnet -d dewiki > \
	datasets/dewiki/sampled_new_user_stats.no_header.tsv

datasets/dewiki/sampled_new_user_stats.table: datasets/dewiki/sampled_new_user_stats.no_header.tsv \
                                              datasets/staging/sampled_new_user_stats.table
	mysql $(staging) -e "DELETE FROM sampled_new_user_stats WHERE wiki_db = 'dewiki';" && \
	ln -s -f sampled_new_user_stats.no_header.tsv datasets/dewiki/sampled_new_user_stats && \
	mysqlimport $(staging) --local datasets/dewiki/sampled_new_user_stats && \
	rm -f datasets/dewiki/sampled_new_user_stats && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_new_user_stats WHERE wiki_db = 'dewiki';" > \
	datasets/dewiki/sampled_new_user_stats.table




                                ##############
                               ## Portuguese ##
################################################################################

####### new_user_survival
datasets/ptwiki/new_user_survival.table: datasets/ptwiki/new_user_survival.no_header.tsv \
                                         datasets/staging/new_user_survival.table
	
	mysql $(staging) -e "DELETE FROM new_user_survival WHERE wiki_db = 'ptwiki';" && \
	ln -s -f new_user_survival.no_header.tsv datasets/ptwiki/new_user_survival && \
	mysqlimport $(staging) --local datasets/ptwiki/new_user_survival && \
	rm -f datasets/ptwiki/new_user_survival && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_survival WHERE wiki_db = 'ptwiki';" > \
	datasets/ptwiki/new_user_survival.table
	
datasets/ptwiki/new_user_survival.no_header.tsv: sql/new_user_survival.sql
	cat sql/new_user_survival.sql | \
	mysql $(ptwiki) -N > \
	datasets/ptwiki/new_user_survival.no_header.tsv
	
####### new_user_revisions
datasets/ptwiki/new_user_revisions.table: datasets/ptwiki/new_user_revisions.no_header.tsv \
                                          datasets/staging/new_user_revisions.table
	
	mysql $(staging) -e "DELETE FROM new_user_revisions WHERE wiki_db = 'ptwiki';" && \
	ln -s -f new_user_revisions.no_header.tsv datasets/ptwiki/new_user_revisions && \
	mysqlimport $(staging) --local datasets/ptwiki/new_user_revisions && \
	rm -f datasets/ptwiki/new_user_revisions && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_revisions WHERE wiki_db = 'ptwiki';" > \
	datasets/ptwiki/new_user_revisions.table
	
datasets/ptwiki/new_user_revisions.no_header.tsv: sql/new_user_revisions.sql
	cat sql/new_user_revisions.sql | \
	mysql $(ptwiki) -N > \
	datasets/ptwiki/new_user_revisions.no_header.tsv

####### new_user_info
datasets/ptwiki/new_user_info.table: datasets/ptwiki/new_user_info.no_header.tsv \
                                     datasets/staging/new_user_info.table
	
	mysql $(staging) -e "DELETE FROM new_user_info WHERE wiki_db = 'ptwiki';" && \
	ln -s -f new_user_info.no_header.tsv datasets/ptwiki/new_user_info && \
	mysqlimport $(staging) --local datasets/ptwiki/new_user_info && \
	rm -f datasets/ptwiki/new_user_info && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_info WHERE wiki_db = 'ptwiki';" > \
	datasets/ptwiki/new_user_info.table
	
datasets/ptwiki/new_user_info.no_header.tsv: sql/new_user_info.sql \
                                              datasets/ptwiki/user_registration_type.table \
                                              datasets/ptwiki/user_registration_approx.table
	echo "SET @wiki_db = 'ptwiki';" | \
	cat - sql/new_user_info.sql | \
	mysql $(staging) -N > \
	datasets/ptwiki/new_user_info.no_header.tsv

####### user_registration_type
datasets/ptwiki/user_registration_type.table: datasets/ptwiki/user_registration_type.no_header.tsv \
                                              datasets/staging/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_type WHERE wiki_db = 'ptwiki';" && \
	ln -s -f user_registration_type.no_header.tsv datasets/ptwiki/user_registration_type && \
	mysqlimport $(staging) --local datasets/ptwiki/user_registration_type && \
	rm -f datasets/ptwiki/user_registration_type && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_type WHERE wiki_db = 'ptwiki';" > \
	datasets/ptwiki/user_registration_type.table
	
datasets/ptwiki/user_registration_type.no_header.tsv: sql/user_registration_type.sql
	cat sql/user_registration_type.sql | \
	mysql $(ptwiki) -N > \
	datasets/ptwiki/user_registration_type.no_header.tsv

####### user_first_edit
datasets/ptwiki/user_first_edit.table: datasets/ptwiki/user_first_edit.no_header.tsv \
                                       datasets/staging/user_first_edit.table
	mysql $(staging) -e "DELETE FROM user_first_edit WHERE wiki_db = 'ptwiki';" && \
	ln -s -f user_first_edit.no_header.tsv datasets/ptwiki/user_first_edit && \
	mysqlimport $(staging) --local datasets/ptwiki/user_first_edit && \
	rm -f datasets/ptwiki/user_first_edit && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_first_edit WHERE wiki_db = 'ptwiki';" > \
	datasets/ptwiki/user_first_edit.table
	
datasets/ptwiki/user_first_edit.no_header.tsv: sql/user_first_edit.sql
	cat sql/user_first_edit.sql | \
	mysql $(ptwiki) -N > \
	datasets/ptwiki/user_first_edit.no_header.tsv
	
####### user_registration_approx
datasets/ptwiki/user_registration_approx.table: datasets/ptwiki/user_registration_approx.no_header.tsv \
                                                datasets/ptwiki/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_approx WHERE wiki_db = 'ptwiki';" && \
	ln -s -f user_registration_approx.no_header.tsv datasets/ptwiki/user_registration_approx && \
	mysqlimport $(staging) --local datasets/ptwiki/user_registration_approx && \
	rm -f datasets/ptwiki/user_registration_approx && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_approx WHERE wiki_db = 'ptwiki';" > \
	datasets/ptwiki/user_registration_approx.table
	
datasets/ptwiki/user_registration_approx.no_header.tsv: sql/old_user_registration_guess.sql \
                                                        datasets/ptwiki/user_first_edit.table
	echo "SET @wiki_db = 'ptwiki';" | \
	cat - sql/old_user_registration_guess.sql | \
	mysql $(staging) | \
	./user_registration_approx --no-header > \
	datasets/ptwiki/user_registration_approx.no_header.tsv

####### sampled_newly_registered_users
datasets/ptwiki/sampled_newly_registered_users.no_header.tsv: sql/sampled_newly_registered_users.sql \
                                                              datasets/ptwiki/new_user_info.table
	echo "SET @wiki_db = 'ptwiki';" | \
	cat - sql/sampled_newly_registered_users.sql | \
	mysql $(staging) > \
	datasets/ptwiki/sampled_newly_registered_users.no_header.tsv
	
datasets/ptwiki/sampled_newly_registered_users.table: datasets/ptwiki/sampled_newly_registered_users.no_header.tsv \
                                                      datasets/staging/sampled_newly_registered_users.table
	mysql $(staging) -e "DELETE FROM sampled_newly_registered_users WHERE wiki_db = 'ptwiki';" && \
	ln -s -f sampled_newly_registered_users.no_header.tsv datasets/ptwiki/sampled_newly_registered_users && \
	mysqlimport $(staging) --local datasets/ptwiki/sampled_newly_registered_users && \
	rm -f datasets/ptwiki/sampled_newly_registered_users && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_newly_registered_users WHERE wiki_db = 'ptwiki';" > \
	datasets/ptwiki/sampled_newly_registered_users.table
	
####### sampled_new_user_stats
datasets/ptwiki/sampled_new_user_stats.no_header.tsv: datasets/ptwiki/sampled_newly_registered_users.table \
                                                      metrics/new_user_stats.py
	mysql $(staging) -e "SELECT * FROM sampled_newly_registered_users WHERE wiki_db = 'ptwiki';" | \
	./new_user_stats --no-headers --defaults-file=~/.my.research.cnf -u research -h s2-analytics-slave.eqiad.wmnet -d ptwiki > \
	datasets/ptwiki/sampled_new_user_stats.no_header.tsv

datasets/ptwiki/sampled_new_user_stats.table: datasets/ptwiki/sampled_new_user_stats.no_header.tsv \
                                              datasets/staging/sampled_new_user_stats.table
	mysql $(staging) -e "DELETE FROM sampled_new_user_stats WHERE wiki_db = 'ptwiki';" && \
	ln -s -f sampled_new_user_stats.no_header.tsv datasets/ptwiki/sampled_new_user_stats && \
	mysqlimport $(staging) --local datasets/ptwiki/sampled_new_user_stats && \
	rm -f datasets/ptwiki/sampled_new_user_stats && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_new_user_stats WHERE wiki_db = 'ptwiki';" > \
	datasets/ptwiki/sampled_new_user_stats.table



                                ###########
                               ## Spanish ##
################################################################################

####### new_user_survival
datasets/eswiki/new_user_survival.table: datasets/eswiki/new_user_survival.no_header.tsv \
                                         datasets/staging/new_user_survival.table
	
	mysql $(staging) -e "DELETE FROM new_user_survival WHERE wiki_db = 'eswiki';" && \
	ln -s -f new_user_survival.no_header.tsv datasets/eswiki/new_user_survival && \
	mysqlimport $(staging) --local datasets/eswiki/new_user_survival && \
	rm -f datasets/eswiki/new_user_survival && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_survival WHERE wiki_db = 'eswiki';" > \
	datasets/eswiki/new_user_survival.table
	
datasets/eswiki/new_user_survival.no_header.tsv: sql/new_user_survival.sql
	cat sql/new_user_survival.sql | \
	mysql $(eswiki) -N > \
	datasets/eswiki/new_user_survival.no_header.tsv
	
####### new_user_revisions
datasets/eswiki/new_user_revisions.table: datasets/eswiki/new_user_revisions.no_header.tsv \
                                          datasets/staging/new_user_revisions.table
	
	mysql $(staging) -e "DELETE FROM new_user_revisions WHERE wiki_db = 'eswiki';" && \
	ln -s -f new_user_revisions.no_header.tsv datasets/eswiki/new_user_revisions && \
	mysqlimport $(staging) --local datasets/eswiki/new_user_revisions && \
	rm -f datasets/eswiki/new_user_revisions && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_revisions WHERE wiki_db = 'eswiki';" > \
	datasets/eswiki/new_user_revisions.table
	
datasets/eswiki/new_user_revisions.no_header.tsv: sql/new_user_revisions.sql
	cat sql/new_user_revisions.sql | \
	mysql $(eswiki) -N > \
	datasets/eswiki/new_user_revisions.no_header.tsv

####### new_user_info
datasets/eswiki/new_user_info.table: datasets/eswiki/new_user_info.no_header.tsv \
                                     datasets/staging/new_user_info.table
	
	mysql $(staging) -e "DELETE FROM new_user_info WHERE wiki_db = 'eswiki';" && \
	ln -s -f new_user_info.no_header.tsv datasets/eswiki/new_user_info && \
	mysqlimport $(staging) --local datasets/eswiki/new_user_info && \
	rm -f datasets/eswiki/new_user_info && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_info WHERE wiki_db = 'eswiki';" > \
	datasets/eswiki/new_user_info.table
	
datasets/eswiki/new_user_info.no_header.tsv: sql/new_user_info.sql \
                                              datasets/eswiki/user_registration_type.table \
                                              datasets/eswiki/user_registration_approx.table
	echo "SET @wiki_db = 'eswiki';" | \
	cat - sql/new_user_info.sql | \
	mysql $(staging) -N > \
	datasets/eswiki/new_user_info.no_header.tsv

####### user_registration_type
datasets/eswiki/user_registration_type.table: datasets/eswiki/user_registration_type.no_header.tsv \
                                              datasets/staging/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_type WHERE wiki_db = 'eswiki';" && \
	ln -s -f user_registration_type.no_header.tsv datasets/eswiki/user_registration_type && \
	mysqlimport $(staging) --local datasets/eswiki/user_registration_type && \
	rm -f datasets/eswiki/user_registration_type && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_type WHERE wiki_db = 'eswiki';" > \
	datasets/eswiki/user_registration_type.table
	
datasets/eswiki/user_registration_type.no_header.tsv: sql/user_registration_type.sql
	cat sql/user_registration_type.sql | \
	mysql $(eswiki) -N > \
	datasets/eswiki/user_registration_type.no_header.tsv

####### user_first_edit
datasets/eswiki/user_first_edit.table: datasets/eswiki/user_first_edit.no_header.tsv \
                                       datasets/staging/user_first_edit.table
	mysql $(staging) -e "DELETE FROM user_first_edit WHERE wiki_db = 'eswiki';" && \
	ln -s -f user_first_edit.no_header.tsv datasets/eswiki/user_first_edit && \
	mysqlimport $(staging) --local datasets/eswiki/user_first_edit && \
	rm -f datasets/eswiki/user_first_edit && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_first_edit WHERE wiki_db = 'eswiki';" > \
	datasets/eswiki/user_first_edit.table
	
datasets/eswiki/user_first_edit.no_header.tsv: sql/user_first_edit.sql
	cat sql/user_first_edit.sql | \
	mysql $(eswiki) -N > \
	datasets/eswiki/user_first_edit.no_header.tsv
	
####### user_registration_approx
datasets/eswiki/user_registration_approx.table: datasets/eswiki/user_registration_approx.no_header.tsv \
                                                datasets/eswiki/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_approx WHERE wiki_db = 'eswiki';" && \
	ln -s -f user_registration_approx.no_header.tsv datasets/eswiki/user_registration_approx && \
	mysqlimport $(staging) --local datasets/eswiki/user_registration_approx && \
	rm -f datasets/eswiki/user_registration_approx && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_approx WHERE wiki_db = 'eswiki';" > \
	datasets/eswiki/user_registration_approx.table
	
datasets/eswiki/user_registration_approx.no_header.tsv: sql/old_user_registration_guess.sql \
                                                        datasets/eswiki/user_first_edit.table
	echo "SET @wiki_db = 'eswiki';" | \
	cat - sql/old_user_registration_guess.sql | \
	mysql $(staging) | \
	./user_registration_approx --no-header > \
	datasets/eswiki/user_registration_approx.no_header.tsv

####### sampled_newly_registered_users
datasets/eswiki/sampled_newly_registered_users.no_header.tsv: sql/sampled_newly_registered_users.sql \
                                                              datasets/eswiki/new_user_info.table
	echo "SET @wiki_db = 'eswiki';" | \
	cat - sql/sampled_newly_registered_users.sql | \
	mysql $(staging) > \
	datasets/eswiki/sampled_newly_registered_users.no_header.tsv
	
datasets/eswiki/sampled_newly_registered_users.table: datasets/eswiki/sampled_newly_registered_users.no_header.tsv \
                                                      datasets/staging/sampled_newly_registered_users.table
	mysql $(staging) -e "DELETE FROM sampled_newly_registered_users WHERE wiki_db = 'eswiki';" && \
	ln -s -f sampled_newly_registered_users.no_header.tsv datasets/eswiki/sampled_newly_registered_users && \
	mysqlimport $(staging) --local datasets/eswiki/sampled_newly_registered_users && \
	rm -f datasets/eswiki/sampled_newly_registered_users && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_newly_registered_users WHERE wiki_db = 'eswiki';" > \
	datasets/eswiki/sampled_newly_registered_users.table
	
####### sampled_new_user_stats
datasets/eswiki/sampled_new_user_stats.no_header.tsv: datasets/eswiki/sampled_newly_registered_users.table \
                                                      metrics/new_user_stats.py
	mysql $(staging) -e "SELECT * FROM sampled_newly_registered_users WHERE wiki_db = 'eswiki';" | \
	./new_user_stats --no-headers --defaults-file=~/.my.research.cnf -u research -h s7-analytics-slave.eqiad.wmnet -d eswiki > \
	datasets/eswiki/sampled_new_user_stats.no_header.tsv

datasets/eswiki/sampled_new_user_stats.table: datasets/eswiki/sampled_new_user_stats.no_header.tsv \
                                              datasets/staging/sampled_new_user_stats.table
	mysql $(staging) -e "DELETE FROM sampled_new_user_stats WHERE wiki_db = 'eswiki';" && \
	ln -s -f sampled_new_user_stats.no_header.tsv datasets/eswiki/sampled_new_user_stats && \
	mysqlimport $(staging) --local datasets/eswiki/sampled_new_user_stats && \
	rm -f datasets/eswiki/sampled_new_user_stats && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_new_user_stats WHERE wiki_db = 'eswiki';" > \
	datasets/eswiki/sampled_new_user_stats.table






                                ##########
                               ## Polish ##
################################################################################

####### new_user_survival
datasets/plwiki/new_user_survival.table: datasets/plwiki/new_user_survival.no_header.tsv \
                                         datasets/staging/new_user_survival.table
	
	mysql $(staging) -e "DELETE FROM new_user_survival WHERE wiki_db = 'plwiki';" && \
	ln -s -f new_user_survival.no_header.tsv datasets/plwiki/new_user_survival && \
	mysqlimport $(staging) --local datasets/plwiki/new_user_survival && \
	rm -f datasets/plwiki/new_user_survival && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_survival WHERE wiki_db = 'plwiki';" > \
	datasets/plwiki/new_user_survival.table
	
datasets/plwiki/new_user_survival.no_header.tsv: sql/new_user_survival.sql
	cat sql/new_user_survival.sql | \
	mysql $(plwiki) -N > \
	datasets/plwiki/new_user_survival.no_header.tsv

####### new_user_revisions
datasets/plwiki/new_user_revisions.table: datasets/plwiki/new_user_revisions.no_header.tsv \
                                          datasets/staging/new_user_revisions.table
	
	mysql $(staging) -e "DELETE FROM new_user_revisions WHERE wiki_db = 'plwiki';" && \
	ln -s -f new_user_revisions.no_header.tsv datasets/plwiki/new_user_revisions && \
	mysqlimport $(staging) --local datasets/plwiki/new_user_revisions && \
	rm -f datasets/plwiki/new_user_revisions && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_revisions WHERE wiki_db = 'plwiki';" > \
	datasets/plwiki/new_user_revisions.table
	
datasets/plwiki/new_user_revisions.no_header.tsv: sql/new_user_revisions.sql
	cat sql/new_user_revisions.sql | \
	mysql $(plwiki) -N > \
	datasets/plwiki/new_user_revisions.no_header.tsv

####### new_user_info
datasets/plwiki/new_user_info.table: datasets/plwiki/new_user_info.no_header.tsv \
                                     datasets/staging/new_user_info.table
	
	mysql $(staging) -e "DELETE FROM new_user_info WHERE wiki_db = 'plwiki';" && \
	ln -s -f new_user_info.no_header.tsv datasets/plwiki/new_user_info && \
	mysqlimport $(staging) --local datasets/plwiki/new_user_info && \
	rm -f datasets/plwiki/new_user_info && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_info WHERE wiki_db = 'plwiki';" > \
	datasets/plwiki/new_user_info.table
	
datasets/plwiki/new_user_info.no_header.tsv: sql/new_user_info.sql \
                                              datasets/plwiki/user_registration_type.table \
                                              datasets/plwiki/user_registration_approx.table
	echo "SET @wiki_db = 'plwiki';" | \
	cat - sql/new_user_info.sql | \
	mysql $(staging) -N > \
	datasets/plwiki/new_user_info.no_header.tsv

####### user_registration_type
datasets/plwiki/user_registration_type.table: datasets/plwiki/user_registration_type.no_header.tsv \
                                              datasets/staging/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_type WHERE wiki_db = 'plwiki';" && \
	ln -s -f user_registration_type.no_header.tsv datasets/plwiki/user_registration_type && \
	mysqlimport $(staging) --local datasets/plwiki/user_registration_type && \
	rm -f datasets/plwiki/user_registration_type && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_type WHERE wiki_db = 'plwiki';" > \
	datasets/plwiki/user_registration_type.table
	
datasets/plwiki/user_registration_type.no_header.tsv: sql/user_registration_type.sql
	cat sql/user_registration_type.sql | \
	mysql $(plwiki) -N > \
	datasets/plwiki/user_registration_type.no_header.tsv

####### user_first_edit
datasets/plwiki/user_first_edit.table: datasets/plwiki/user_first_edit.no_header.tsv \
                                       datasets/staging/user_first_edit.table
	mysql $(staging) -e "DELETE FROM user_first_edit WHERE wiki_db = 'plwiki';" && \
	ln -s -f user_first_edit.no_header.tsv datasets/plwiki/user_first_edit && \
	mysqlimport $(staging) --local datasets/plwiki/user_first_edit && \
	rm -f datasets/plwiki/user_first_edit && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_first_edit WHERE wiki_db = 'plwiki';" > \
	datasets/plwiki/user_first_edit.table
	
datasets/plwiki/user_first_edit.no_header.tsv: sql/user_first_edit.sql
	cat sql/user_first_edit.sql | \
	mysql $(plwiki) -N > \
	datasets/plwiki/user_first_edit.no_header.tsv
	
####### user_registration_approx
datasets/plwiki/user_registration_approx.table: datasets/plwiki/user_registration_approx.no_header.tsv \
                                                datasets/plwiki/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_approx WHERE wiki_db = 'plwiki';" && \
	ln -s -f user_registration_approx.no_header.tsv datasets/plwiki/user_registration_approx && \
	mysqlimport $(staging) --local datasets/plwiki/user_registration_approx && \
	rm -f datasets/plwiki/user_registration_approx && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_approx WHERE wiki_db = 'plwiki';" > \
	datasets/plwiki/user_registration_approx.table
	
datasets/plwiki/user_registration_approx.no_header.tsv: sql/old_user_registration_guess.sql \
                                                        datasets/plwiki/user_first_edit.table
	echo "SET @wiki_db = 'plwiki';" | \
	cat - sql/old_user_registration_guess.sql | \
	mysql $(staging) | \
	./user_registration_approx --no-header > \
	datasets/plwiki/user_registration_approx.no_header.tsv

####### sampled_newly_registered_users
datasets/plwiki/sampled_newly_registered_users.no_header.tsv: sql/sampled_newly_registered_users.sql \
                                                              datasets/plwiki/new_user_info.table
	echo "SET @wiki_db = 'plwiki';" | \
	cat - sql/sampled_newly_registered_users.sql | \
	mysql $(staging) > \
	datasets/plwiki/sampled_newly_registered_users.no_header.tsv
	
datasets/plwiki/sampled_newly_registered_users.table: datasets/plwiki/sampled_newly_registered_users.no_header.tsv \
                                                      datasets/staging/sampled_newly_registered_users.table
	mysql $(staging) -e "DELETE FROM sampled_newly_registered_users WHERE wiki_db = 'plwiki';" && \
	ln -s -f sampled_newly_registered_users.no_header.tsv datasets/plwiki/sampled_newly_registered_users && \
	mysqlimport $(staging) --local datasets/plwiki/sampled_newly_registered_users && \
	rm -f datasets/plwiki/sampled_newly_registered_users && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_newly_registered_users WHERE wiki_db = 'plwiki';" > \
	datasets/plwiki/sampled_newly_registered_users.table
	
####### sampled_new_user_stats
datasets/plwiki/sampled_new_user_stats.no_header.tsv: datasets/plwiki/sampled_newly_registered_users.table \
                                                      metrics/new_user_stats.py
	mysql $(staging) -e "SELECT * FROM sampled_newly_registered_users WHERE wiki_db = 'plwiki';" | \
	./new_user_stats --no-headers --defaults-file=~/.my.research.cnf -u research -h s2-analytics-slave.eqiad.wmnet -d plwiki > \
	datasets/plwiki/sampled_new_user_stats.no_header.tsv

datasets/plwiki/sampled_new_user_stats.table: datasets/plwiki/sampled_new_user_stats.no_header.tsv \
                                              datasets/staging/sampled_new_user_stats.table
	mysql $(staging) -e "DELETE FROM sampled_new_user_stats WHERE wiki_db = 'plwiki';" && \
	ln -s -f sampled_new_user_stats.no_header.tsv datasets/plwiki/sampled_new_user_stats && \
	mysqlimport $(staging) --local datasets/plwiki/sampled_new_user_stats && \
	rm -f datasets/plwiki/sampled_new_user_stats && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_new_user_stats WHERE wiki_db = 'plwiki';" > \
	datasets/plwiki/sampled_new_user_stats.table






                                ##########
                               ## French ##
################################################################################

####### new_user_survival
datasets/frwiki/new_user_survival.table: datasets/frwiki/new_user_survival.no_header.tsv \
                                         datasets/staging/new_user_survival.table
	
	mysql $(staging) -e "DELETE FROM new_user_survival WHERE wiki_db = 'frwiki';" && \
	ln -s -f new_user_survival.no_header.tsv datasets/frwiki/new_user_survival && \
	mysqlimport $(staging) --local datasets/frwiki/new_user_survival && \
	rm -f datasets/frwiki/new_user_survival && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_survival WHERE wiki_db = 'frwiki';" > \
	datasets/frwiki/new_user_survival.table
	
datasets/frwiki/new_user_survival.no_header.tsv: sql/new_user_survival.sql
	cat sql/new_user_survival.sql | \
	mysql $(frwiki) -N > \
	datasets/frwiki/new_user_survival.no_header.tsv

####### new_user_revisions
datasets/frwiki/new_user_revisions.table: datasets/frwiki/new_user_revisions.no_header.tsv \
                                          datasets/staging/new_user_revisions.table
	
	mysql $(staging) -e "DELETE FROM new_user_revisions WHERE wiki_db = 'frwiki';" && \
	ln -s -f new_user_revisions.no_header.tsv datasets/frwiki/new_user_revisions && \
	mysqlimport $(staging) --local datasets/frwiki/new_user_revisions && \
	rm -f datasets/frwiki/new_user_revisions && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_revisions WHERE wiki_db = 'frwiki';" > \
	datasets/frwiki/new_user_revisions.table
	
datasets/frwiki/new_user_revisions.no_header.tsv: sql/new_user_revisions.sql
	cat sql/new_user_revisions.sql | \
	mysql $(frwiki) -N > \
	datasets/frwiki/new_user_revisions.no_header.tsv

####### new_user_info
datasets/frwiki/new_user_info.table: datasets/frwiki/new_user_info.no_header.tsv \
                                     datasets/staging/new_user_info.table
	
	mysql $(staging) -e "DELETE FROM new_user_info WHERE wiki_db = 'frwiki';" && \
	ln -s -f new_user_info.no_header.tsv datasets/frwiki/new_user_info && \
	mysqlimport $(staging) --local datasets/frwiki/new_user_info && \
	rm -f datasets/frwiki/new_user_info && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_info WHERE wiki_db = 'frwiki';" > \
	datasets/frwiki/new_user_info.table
	
datasets/frwiki/new_user_info.no_header.tsv: sql/new_user_info.sql \
                                              datasets/frwiki/user_registration_type.table \
                                              datasets/frwiki/user_registration_approx.table
	echo "SET @wiki_db = 'frwiki';" | \
	cat - sql/new_user_info.sql | \
	mysql $(staging) -N > \
	datasets/frwiki/new_user_info.no_header.tsv

####### user_registration_type
datasets/frwiki/user_registration_type.table: datasets/frwiki/user_registration_type.no_header.tsv \
                                              datasets/staging/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_type WHERE wiki_db = 'frwiki';" && \
	ln -s -f user_registration_type.no_header.tsv datasets/frwiki/user_registration_type && \
	mysqlimport $(staging) --local datasets/frwiki/user_registration_type && \
	rm -f datasets/frwiki/user_registration_type && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_type WHERE wiki_db = 'frwiki';" > \
	datasets/frwiki/user_registration_type.table
	
datasets/frwiki/user_registration_type.no_header.tsv: sql/user_registration_type.sql
	cat sql/user_registration_type.sql | \
	mysql $(frwiki) -N > \
	datasets/frwiki/user_registration_type.no_header.tsv

####### user_first_edit
datasets/frwiki/user_first_edit.table: datasets/frwiki/user_first_edit.no_header.tsv \
                                       datasets/staging/user_first_edit.table
	mysql $(staging) -e "DELETE FROM user_first_edit WHERE wiki_db = 'frwiki';" && \
	ln -s -f user_first_edit.no_header.tsv datasets/frwiki/user_first_edit && \
	mysqlimport $(staging) --local datasets/frwiki/user_first_edit && \
	rm -f datasets/frwiki/user_first_edit && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_first_edit WHERE wiki_db = 'frwiki';" > \
	datasets/frwiki/user_first_edit.table
	
datasets/frwiki/user_first_edit.no_header.tsv: sql/user_first_edit.sql
	cat sql/user_first_edit.sql | \
	mysql $(frwiki) -N > \
	datasets/frwiki/user_first_edit.no_header.tsv
	
####### user_registration_approx
datasets/frwiki/user_registration_approx.table: datasets/frwiki/user_registration_approx.no_header.tsv \
                                                datasets/frwiki/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_approx WHERE wiki_db = 'frwiki';" && \
	ln -s -f user_registration_approx.no_header.tsv datasets/frwiki/user_registration_approx && \
	mysqlimport $(staging) --local datasets/frwiki/user_registration_approx && \
	rm -f datasets/frwiki/user_registration_approx && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_approx WHERE wiki_db = 'frwiki';" > \
	datasets/frwiki/user_registration_approx.table
	
datasets/frwiki/user_registration_approx.no_header.tsv: sql/old_user_registration_guess.sql \
                                                        datasets/frwiki/user_first_edit.table
	echo "SET @wiki_db = 'frwiki';" | \
	cat - sql/old_user_registration_guess.sql | \
	mysql $(staging) | \
	./user_registration_approx --no-header > \
	datasets/frwiki/user_registration_approx.no_header.tsv

####### sampled_newly_registered_users
datasets/frwiki/sampled_newly_registered_users.no_header.tsv: sql/sampled_newly_registered_users.sql \
                                                              datasets/frwiki/new_user_info.table
	echo "SET @wiki_db = 'frwiki';" | \
	cat - sql/sampled_newly_registered_users.sql | \
	mysql $(staging) > \
	datasets/frwiki/sampled_newly_registered_users.no_header.tsv
	
datasets/frwiki/sampled_newly_registered_users.table: datasets/frwiki/sampled_newly_registered_users.no_header.tsv \
                                                      datasets/staging/sampled_newly_registered_users.table
	mysql $(staging) -e "DELETE FROM sampled_newly_registered_users WHERE wiki_db = 'frwiki';" && \
	ln -s -f sampled_newly_registered_users.no_header.tsv datasets/frwiki/sampled_newly_registered_users && \
	mysqlimport $(staging) --local datasets/frwiki/sampled_newly_registered_users && \
	rm -f datasets/frwiki/sampled_newly_registered_users && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_newly_registered_users WHERE wiki_db = 'frwiki';" > \
	datasets/frwiki/sampled_newly_registered_users.table
	
####### sampled_new_user_stats
datasets/frwiki/sampled_new_user_stats.no_header.tsv: datasets/frwiki/sampled_newly_registered_users.table \
                                                      metrics/new_user_stats.py
	mysql $(staging) -e "SELECT * FROM sampled_newly_registered_users WHERE wiki_db = 'frwiki';" | \
	./new_user_stats --no-headers --defaults-file=~/.my.research.cnf -u research -h s6-analytics-slave.eqiad.wmnet -d frwiki > \
	datasets/frwiki/sampled_new_user_stats.no_header.tsv

datasets/frwiki/sampled_new_user_stats.table: datasets/frwiki/sampled_new_user_stats.no_header.tsv \
                                              datasets/staging/sampled_new_user_stats.table
	mysql $(staging) -e "DELETE FROM sampled_new_user_stats WHERE wiki_db = 'frwiki';" && \
	ln -s -f sampled_new_user_stats.no_header.tsv datasets/frwiki/sampled_new_user_stats && \
	mysqlimport $(staging) --local datasets/frwiki/sampled_new_user_stats && \
	rm -f datasets/frwiki/sampled_new_user_stats && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_new_user_stats WHERE wiki_db = 'frwiki';" > \
	datasets/frwiki/sampled_new_user_stats.table
	





                                ###########
                               ## Russian ##
################################################################################

####### new_user_survival
datasets/ruwiki/new_user_survival.table: datasets/ruwiki/new_user_survival.no_header.tsv \
                                         datasets/staging/new_user_survival.table
	
	mysql $(staging) -e "DELETE FROM new_user_survival WHERE wiki_db = 'ruwiki';" && \
	ln -s -f new_user_survival.no_header.tsv datasets/ruwiki/new_user_survival && \
	mysqlimport $(staging) --local datasets/ruwiki/new_user_survival && \
	rm -f datasets/ruwiki/new_user_survival && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_survival WHERE wiki_db = 'ruwiki';" > \
	datasets/ruwiki/new_user_survival.table
	
datasets/ruwiki/new_user_survival.no_header.tsv: sql/new_user_survival.sql
	cat sql/new_user_survival.sql | \
	mysql $(ruwiki) -N > \
	datasets/ruwiki/new_user_survival.no_header.tsv

####### new_user_revisions
datasets/ruwiki/new_user_revisions.table: datasets/ruwiki/new_user_revisions.no_header.tsv \
                                          datasets/staging/new_user_revisions.table
	
	mysql $(staging) -e "DELETE FROM new_user_revisions WHERE wiki_db = 'ruwiki';" && \
	ln -s -f new_user_revisions.no_header.tsv datasets/ruwiki/new_user_revisions && \
	mysqlimport $(staging) --local datasets/ruwiki/new_user_revisions && \
	rm -f datasets/ruwiki/new_user_revisions && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_revisions WHERE wiki_db = 'ruwiki';" > \
	datasets/ruwiki/new_user_revisions.table
	
datasets/ruwiki/new_user_revisions.no_header.tsv: sql/new_user_revisions.sql
	cat sql/new_user_revisions.sql | \
	mysql $(ruwiki) -N > \
	datasets/ruwiki/new_user_revisions.no_header.tsv

####### new_user_info
datasets/ruwiki/new_user_info.table: datasets/ruwiki/new_user_info.no_header.tsv \
                                     datasets/staging/new_user_info.table
	
	mysql $(staging) -e "DELETE FROM new_user_info WHERE wiki_db = 'ruwiki';" && \
	ln -s -f new_user_info.no_header.tsv datasets/ruwiki/new_user_info && \
	mysqlimport $(staging) --local datasets/ruwiki/new_user_info && \
	rm -f datasets/ruwiki/new_user_info && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM new_user_info WHERE wiki_db = 'ruwiki';" > \
	datasets/ruwiki/new_user_info.table
	
datasets/ruwiki/new_user_info.no_header.tsv: sql/new_user_info.sql \
                                              datasets/ruwiki/user_registration_type.table \
                                              datasets/ruwiki/user_registration_approx.table
	echo "SET @wiki_db = 'ruwiki';" | \
	cat - sql/new_user_info.sql | \
	mysql $(staging) -N > \
	datasets/ruwiki/new_user_info.no_header.tsv

####### user_registration_type
datasets/ruwiki/user_registration_type.table: datasets/ruwiki/user_registration_type.no_header.tsv \
                                              datasets/staging/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_type WHERE wiki_db = 'ruwiki';" && \
	ln -s -f user_registration_type.no_header.tsv datasets/ruwiki/user_registration_type && \
	mysqlimport $(staging) --local datasets/ruwiki/user_registration_type && \
	rm -f datasets/ruwiki/user_registration_type && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_type WHERE wiki_db = 'ruwiki';" > \
	datasets/ruwiki/user_registration_type.table
	
datasets/ruwiki/user_registration_type.no_header.tsv: sql/user_registration_type.sql
	cat sql/user_registration_type.sql | \
	mysql $(ruwiki) -N > \
	datasets/ruwiki/user_registration_type.no_header.tsv

####### user_first_edit
datasets/ruwiki/user_first_edit.table: datasets/ruwiki/user_first_edit.no_header.tsv \
                                       datasets/staging/user_first_edit.table
	mysql $(staging) -e "DELETE FROM user_first_edit WHERE wiki_db = 'ruwiki';" && \
	ln -s -f user_first_edit.no_header.tsv datasets/ruwiki/user_first_edit && \
	mysqlimport $(staging) --local datasets/ruwiki/user_first_edit && \
	rm -f datasets/ruwiki/user_first_edit && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_first_edit WHERE wiki_db = 'ruwiki';" > \
	datasets/ruwiki/user_first_edit.table
	
datasets/ruwiki/user_first_edit.no_header.tsv: sql/user_first_edit.sql
	cat sql/user_first_edit.sql | \
	mysql $(ruwiki) -N > \
	datasets/ruwiki/user_first_edit.no_header.tsv
	
####### user_registration_approx
datasets/ruwiki/user_registration_approx.table: datasets/ruwiki/user_registration_approx.no_header.tsv \
                                                datasets/ruwiki/user_registration_type.table
	mysql $(staging) -e "DELETE FROM user_registration_approx WHERE wiki_db = 'ruwiki';" && \
	ln -s -f user_registration_approx.no_header.tsv datasets/ruwiki/user_registration_approx && \
	mysqlimport $(staging) --local datasets/ruwiki/user_registration_approx && \
	rm -f datasets/ruwiki/user_registration_approx && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM user_registration_approx WHERE wiki_db = 'ruwiki';" > \
	datasets/ruwiki/user_registration_approx.table
	
datasets/ruwiki/user_registration_approx.no_header.tsv: sql/old_user_registration_guess.sql \
                                                        datasets/ruwiki/user_first_edit.table
	echo "SET @wiki_db = 'ruwiki';" | \
	cat - sql/old_user_registration_guess.sql | \
	mysql $(staging) | \
	./user_registration_approx --no-header > \
	datasets/ruwiki/user_registration_approx.no_header.tsv

####### sampled_newly_registered_users
datasets/ruwiki/sampled_newly_registered_users.no_header.tsv: sql/sampled_newly_registered_users.sql \
                                                              datasets/ruwiki/new_user_info.table
	echo "SET @wiki_db = 'ruwiki';" | \
	cat - sql/sampled_newly_registered_users.sql | \
	mysql $(staging) > \
	datasets/ruwiki/sampled_newly_registered_users.no_header.tsv
	
datasets/ruwiki/sampled_newly_registered_users.table: datasets/ruwiki/sampled_newly_registered_users.no_header.tsv \
                                                      datasets/staging/sampled_newly_registered_users.table
	mysql $(staging) -e "DELETE FROM sampled_newly_registered_users WHERE wiki_db = 'ruwiki';" && \
	ln -s -f sampled_newly_registered_users.no_header.tsv datasets/ruwiki/sampled_newly_registered_users && \
	mysqlimport $(staging) --local datasets/ruwiki/sampled_newly_registered_users && \
	rm -f datasets/ruwiki/sampled_newly_registered_users && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_newly_registered_users WHERE wiki_db = 'ruwiki';" > \
	datasets/ruwiki/sampled_newly_registered_users.table
	
####### sampled_new_user_stats
datasets/ruwiki/sampled_new_user_stats.no_header.tsv: datasets/ruwiki/sampled_newly_registered_users.table \
                                                      metrics/new_user_stats.py
	mysql $(staging) -e "SELECT * FROM sampled_newly_registered_users WHERE wiki_db = 'ruwiki';" | \
	./new_user_stats --no-headers --defaults-file=~/.my.research.cnf -u research -h s6-analytics-slave.eqiad.wmnet -d ruwiki > \
	datasets/ruwiki/sampled_new_user_stats.no_header.tsv

datasets/ruwiki/sampled_new_user_stats.table: datasets/ruwiki/sampled_new_user_stats.no_header.tsv \
                                              datasets/staging/sampled_new_user_stats.table
	mysql $(staging) -e "DELETE FROM sampled_new_user_stats WHERE wiki_db = 'ruwiki';" && \
	ln -s -f sampled_new_user_stats.no_header.tsv datasets/ruwiki/sampled_new_user_stats && \
	mysqlimport $(staging) --local datasets/ruwiki/sampled_new_user_stats && \
	rm -f datasets/ruwiki/sampled_new_user_stats && \
	mysql $(staging) -e "SELECT COUNT(*), NOW() FROM sampled_new_user_stats WHERE wiki_db = 'ruwiki';" > \
	datasets/ruwiki/sampled_new_user_stats.table
