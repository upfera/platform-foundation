#!/usr/bin/env python3
import os
import json
import sys

RED = '\033[91m'
BOLD = '\033[1m'
END = '\033[0m'
def get_inventory():
    try:
        hosts_env = os.environ['BOOTSTRAP_HOSTS'].strip()
    except KeyError:
        msg = f"{RED}{BOLD}ERROR!{END} {RED}BOOTSTRAP_HOSTS environment variable is required{END}"
        print(msg, file=sys.stderr)
        sys.exit(1)

    hosts = [h.strip() for h in hosts_env.split(',') if h.strip()]
    
    return {
        "all": {
            "hosts": hosts,
            "vars": {}
        },
        "_meta": {
            "hostvars": {}
        }
    }

if __name__ == "__main__":
    print(json.dumps(get_inventory(), indent=2))
