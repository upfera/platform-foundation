#!/usr/bin/env python3
import os
import json
import sys

def get_inventory():
    try:
        server_hosts_env = os.environ['K3S_SERVER_HOSTS'].strip()
        agent_hosts_env = os.environ['K3S_AGENT_HOSTS'].strip()
    except KeyError as e:
        sys.stderr.write(f"ERROR: {e.args[0]} environment variable is required\n")
        sys.exit(1)
    
    servers = [h.strip() for h in server_hosts_env.split(',') if h.strip()]
    agents = [h.strip() for h in agent_hosts_env.split(',') if h.strip()]
    
    return {
        "k3s_cluster": {
            "children": ["server", "agent"]
        },
        "server": {
            "hosts": servers
        },
        "agent": {
            "hosts": agents
        },
        "_meta": {
            "hostvars": {
                host: {
                    "k3s_role": "server" if host in servers else "agent"
                }
                for host in servers + agents
            }
        }
    }

if __name__ == "__main__":
    print(json.dumps(get_inventory(), indent=2))
