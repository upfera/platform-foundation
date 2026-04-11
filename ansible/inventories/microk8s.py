#!/usr/bin/env python3
import os
import json
import sys

RED = "\033[91m"
RESET = "\033[0m"

def get_inventory():
    try:
        microk8s_host = os.environ['MICROK8S_HOST'].strip()
    except KeyError as e:
        raise SystemExit("Error: {e.args[0]} environment variable is required")
    
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
