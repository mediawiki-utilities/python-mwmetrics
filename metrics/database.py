import getpass
import os

import pymysql
import pymysql.cursors


def connection(wiki,
               defaults_file = os.path.expanduser("~/.my.cnf"),
               user = getpass.getuser()):
	
	return pymysql.connect(
		host="analytics-store.eqiad.wmnet", #TODO: hard coded
		database=wiki,
		user=user,
		read_default_file=defaults_file#,
		#cursorclass=pymysql.cursors.DictCursor
	)
