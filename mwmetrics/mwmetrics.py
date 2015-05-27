"""
This script provides access to a set of utilities generating standardized user
metrics.

* new_user_stats -- Extracts newcomer-relevant metrics for a set of users
* user_registration_approx -- Processes user registrations before

Usage:
    mwmetrics (-h | --help)
    mwmetrics <utility> [-h | --help]

Options:
    -h | --help  Shows this documentation
    <utility>    The name of the utility to run
"""
import sys
import traceback
from importlib import import_module

import docopt


USAGE = """Usage:
    mwmetrics (-h | --help)
    mwmetrics <utility> [-h | --help]\n"""


def main():

    if len(sys.argv) < 2:
        sys.stderr.write(USAGE)
        sys.exit(1)
    elif sys.argv[1] in ("-h", "--help"):
        sys.stderr.write(__doc__ + "\n")
        sys.exit(1)
    elif sys.argv[1][:1] == "-":
        sys.stderr.write(USAGE)
        sys.exit(1)

    module_name = sys.argv[1]
    try:
        sys.path.insert(0, ".")
        module = import_module(".utilities." + module_name, package="mwmetrics")
    except ImportError:
        sys.stderr.write(traceback.format_exc())
        sys.stderr.write("Could not find utility {0}.\n".format(module_name))
        sys.exit(1)

    module.main(sys.argv[2:])
