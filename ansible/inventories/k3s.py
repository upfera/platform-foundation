#!/usr/bin/env python3
import os
import json
import sys

def get_inventory():
    server_hosts_env = os.environ.get('K3S_SERVER_HOSTS', '192.168.1.10')
    agent_hosts_env = os.environ.get('K3S_AGENT_HOSTS', '192.168.1.11,192.168.1.12')
    
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
