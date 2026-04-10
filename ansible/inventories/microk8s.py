#!/usr/bin/env python3
import os
import json
import sys

def get_inventory():
    try:
        microk8s_host = os.environ['MICROK8S_HOST'].strip()
    except KeyError:
        sys.stderr.write("ERROR: MICROK8S_HOST environment variable is required\n")
        sys.exit(1)
    
    hosts = [microk8s_host] if microk8s_host else []
    
    return {
        "microk8s_cluster": {
            "hosts": hosts
        },
        "_meta": {
            "hostvars": {}
        }
    }

if __name__ == "__main__":
    print(json.dumps(get_inventory(), indent=2))
