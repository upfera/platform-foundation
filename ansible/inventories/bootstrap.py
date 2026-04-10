#!/usr/bin/env python3
import os
import json
import logging
import sys

RED = "\033[91m"
RESET = "\033[0m"

def get_inventory():
    try:
        hosts_env = os.environ['BOOTSTRAP_HOSTS'].strip()
    except KeyError:
        RED = '\033[31m'
        RESET = '\033[0m'
        sys.stderr.write(f"{RED}ERROR: BOOTSTRAP_HOSTS environment variable is required{RESET}\n")
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
