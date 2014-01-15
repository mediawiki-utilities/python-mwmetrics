# Requires python3
import argparse, sys

from mw import database
from mw.types import Timestamp

from .util import tsv

def parse_users(f):
	if not f.isatty():
		return tsv.Reader(f, types=[int, tsv.utf8, tsv.utf8])

def main():
	
	parser = argparse.ArgumentParser(
		description = "Takes a list of users and the data necessary to make " + 
		              "judgements about productivity",
		conflict_handler="resolve"
	)
	parser.add_argument(
		"--users",
		help="Input file containing a list of user_ids",
		type=lambda path: parse_users(open(path)),
		default=parse_users(sys.stdin)
	)
	parser.add_argument(
		"-t", "--lifetime",
		help="How much time after registration should a user's " + \
		     "contributions be examined? (seconds)",
		type=int,
		default=60*60*24*7 # One week
	)
	parser.add_argument(
		"--revert_cutoff",
		help="How long to wait for a revert to occur? (seconds)",
		type=int,
		default=60*60*24*2 # Two days
	)
	parser.add_argument(
		"--revert_radius",
		help="How many revisions can a reverting revision revert?",
		type=int,
		default=15
	)
	
	database.DB.add_args(parser)
	
	args = parser.parse_args()
	
	db = database.DB.from_args(args)
	
	run(db, args.users, args.lifetime, 
	        args.revert_cutoff, args.revert_radius)


def run(db, users, lifetime, revert_cutoff, revert_radius):
	
	output = tsv.Writer(sys.stdout, 
	                    headers=["user_id", 
	                             "revisions", 
	                             "main_revisions", 
	                             "reverted_main_revisions"])
	
	for user in users:
		
		revisions = 0
		main_revisions = 0
		reverted_main_revisions = 0
		
		registration = Timestamp(user.user_registration)
		end_of_life = Timestamp(int(registration) + lifetime)
		
		user_revisions = db.revisions.query(
			user_id=user.user_id, 
			direction="newer",
			before=end_of_life,
			include_page=True
		)
		
		for rev in user_revisions:
			revisions += 1
			
			if rev['page_namespace'] == 0:
				main_revisions += 1
				
				rev_timestamp = Timestamp(rev['rev_timestamp'])
				cutoff_timestamp = Timestamp(int(rev_timestamp) + revert_cutoff)
				
				revert = db.revisions.revert(rev, radius=revert_radius,
				                                  before=cutoff_timestamp)
				
				if revert != None: # Reverted edit!
					reverted_main_revisions += 1
					sys.stderr.write("r")
				else:
					sys.stderr.write(".")
			else:
				sys.stderr.write("_")
				
			
		
		sys.stderr.write(str(int(main_revisions > reverted_main_revisions)))
		output.write([user.user_id, revisions, main_revisions, reverted_main_revisions])
	
	sys.stderr.write("\n")
