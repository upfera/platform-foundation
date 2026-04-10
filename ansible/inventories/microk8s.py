#!/usr/bin/env python3
import os
import json
import sys

def get_inventory():
    microk8s_host = os.environ.get('MICROK8S_HOST', '192.168.1.20')
    
    hosts = [microk8s_host.strip()] if microk8s_host.strip() else []
    
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
