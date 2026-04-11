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
    except KeyError as e:
        raise SystemExit("Error: {e.args[0]} environment variable is required")

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
