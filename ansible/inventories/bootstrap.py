#!/usr/bin/env python3
import os
import json
import sys

def get_inventory():
    try:
        hosts_env = os.environ['BOOTSTRAP_HOSTS'].strip()
    except KeyError:
        sys.stderr.write("ERROR: BOOTSTRAP_HOSTS environment variable is required\n")
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
