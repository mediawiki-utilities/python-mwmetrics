# Requires python3
import argparse, sys

from mwutil import database
from mwutil.types import Timestamp

from .util import tsv

HEADERS = [
	"wiki_db",
	"user_id", 
	"registration_approx",
	"day_revisions",
	"day_main_revisions",
	"day_reverted_main_revisions",
	"week_revisions",
	"week_main_revisions",
	"week_reverted_main_revisions"
]

def parse_users(f):
	if not f.isatty():
		return tsv.Reader(f, types=[str, int, str])

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
	parser.add_argument(
		"--no-headers",
		help="Skip printing the headers",
		action="store_true"
	)
	
	database.DB.add_args(parser)
	
	args = parser.parse_args()
	
	db = database.DB.from_args(args)
	
	run(db, args.users, args.revert_cutoff, args.revert_radius, args.no_headers)


def run(db, users, revert_cutoff, revert_radius, no_headers):
	
	if no_headers:
		headers=None
	else:
		headers=HEADERS
	
	output = tsv.Writer(sys.stdout, headers=headers)
	
	for user in users:
		sys.stderr.write("{0}: ".format(user.user_id))
		day_revisions = 0
		day_main_revisions = 0
		day_reverted_main_revisions = 0
		week_revisions = 0
		week_main_revisions = 0
		week_reverted_main_revisions = 0
		
		registration = Timestamp(user.registration_approx)
		end_of_life = Timestamp(int(registration) + 60*60*24*7) # One week
		
		user_revisions = db.revisions.query(
			user_id=user.user_id, 
			direction="newer",
			before=end_of_life,
			include_page=True
		)
		
		for rev in user_revisions:
			day = Timestamp(rev['rev_timestamp']) - registration <= 60*60*24 # one day
			
			week_revisions += 1
			day_revisions += day
			
			if rev['page_namespace'] == 0:
				week_main_revisions += 1
				day_main_revisions += day
				
				rev_timestamp = Timestamp(rev['rev_timestamp'])
				cutoff_timestamp = Timestamp(int(rev_timestamp) + revert_cutoff)
				
				revert = db.revisions.revert(rev, radius=revert_radius,
				                                  before=cutoff_timestamp)
				
				if revert != None: # Reverted edit!
					week_reverted_main_revisions += 1
					day_reverted_main_revisions += day
					sys.stderr.write("r")
				else:
					sys.stderr.write(".")
			else:
				sys.stderr.write("_")
				
		
		sys.stderr.write("\n")
		output.write([
			user.wiki_db,
			user.user_id,
			day_revisions,
			day_main_revisions,
			day_reverted_main_revisions,
			week_revisions,
			week_main_revisions,
			week_reverted_main_revisions
		])
	
