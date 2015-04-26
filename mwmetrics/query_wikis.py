import argparse
import datetime
import sys
import traceback

import pymysql
from menagerie.formatting import tsv

from . import database


def read_wikis(f):
    if not f.isatty():
        return list(row.wiki for row in tsv.Reader(f))
    

def read_query(f):
    if not f.isatty():
        return f.read()

def main():
    
    parser = argparse.ArgumentParser(
        description = """
            Queries a set of wikis and aggregates results
        """,
        conflict_handler = "resolve"
    )
    parser.add_argument(
        'wikis',
        help="A file containing the list of wikis to process.",
        type=lambda path: read_wikis(open(path))
    )
    parser.add_argument(
        '--query',
        help="The query to run.",
        type=lambda path: read_query(open(path))
    )
    parser.add_argument(
        '--no-headers',
        help="Skip printing headers.",
        action="store_true"
    )
    
    args = parser.parse_args()
    
    run(
        args.wikis,
        args.query,
        args.no_headers
    )


def run(wikis, query, no_headers):
    
    # Will initialize when we receieve the first row
    writer = None
    
    for wiki in wikis:
        
        try:
            conn = database.connection(wiki, user="research")
            cursor = conn.cursor()
            sys.stderr.write("Querying {0}\n".format(wiki))
            cursor.execute(query)
            
            for row in cursor:
                if no_headers: headers = None
                else: headers = [d[0] for d in cursor.description]
                if writer == None: writer = initialize_writer(headers)
                
                writer.write(row)
            
        except KeyboardInterrupt as e:
            raise
        except Exception as e:
            sys.stderr.write(traceback.format_exc())
        finally:
            try:
                conn.close()
            except:
                pass
            
        
    

def initialize_writer(headers):
    return tsv.Writer(sys.stdout, headers=headers)
