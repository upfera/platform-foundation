#!/usr/bin/env python3
import os
import json
import sys

def get_inventory():
    vpn_ip = os.environ.get('VPN_IP', '').strip()
    
    if not vpn_ip:
        # If VPN_IP is not set, we return an empty inventory or error
        # In automation context, error is better to fail early
        print("Error: VPN_IP environment variable is required", file=sys.stderr)
        return {"_meta": {"hostvars": {}}}

    return {
        "_meta": {
            "hostvars": {
                vpn_ip: {
                    "ansible_host": vpn_ip
                }
            }
        },
        "all": {
            "hosts": [vpn_ip],
            "vars": {}
        },
        "wireguard": {
            "hosts": [vpn_ip]
        }
    }

if __name__ == "__main__":
    inventory = get_inventory()
    if "_meta" not in inventory and "all" not in inventory:
        sys.exit(1)
    print(json.dumps(inventory, indent=2))
