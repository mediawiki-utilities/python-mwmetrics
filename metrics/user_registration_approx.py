import sys, argparse
from .util import tsv

def user_registrations(f):
	if not f.isatty():
		return tsv.Reader(f, types=[str, int, str, str])
	

def if_none(val, none_val):
	if val == None:
		return none_val
	else:
		return val


HEADERS = ["wiki_db", "user_id", "registration_approx"]

def main():
	parser = argparse.ArgumentParser(
		description = """
			Reads an list of users ordered by their user_id (descending)
			and propagates dates to serve as an approximation.
		""",
		conflict_handler="resolve"
	)
	parser.add_argument(
		"--no-headers",
		help="Don't print the header row.  (Good for DB imports)",
		action="store_true"
	)
	args = parser.parse_args()
	
	if args.no_headers:
		headers = None
	else:
		headers = HEADERS
	
	reader = user_registrations(sys.stdin)
	writer = tsv.Writer(sys.stdout, headers=headers)
	
	registration_approx = None
	for row in reader:
		
		if registration_approx == None:
			# Set for the first row
			registration_approx = row.first_edit
		elif row.first_edit != None:
			# Update to min
			registration_approx = min(registration_approx, row.first_edit)
		
		writer.write([
			row.wiki_db, 
			row.user_id, 
			registration_approx
		])
		
	
if __name__ == "__main__": main()
