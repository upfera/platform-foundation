#!/usr/bin/env python3
import os
import json
import sys

def get_inventory():
    hosts_env = os.environ.get('BOOTSTRAP_HOSTS', '192.168.1.10') # Default for example or testing
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
