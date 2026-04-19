#!/usr/bin/env python3
import os
import json
import sys
from typing import Any, Dict, List


def load_json_env(var_name: str, required: bool = True) -> List[Dict[str, Any]]:
    raw = os.environ.get(var_name)

    if raw is None or not raw.strip() or raw.strip().lower() == "null":
        if required:
            raise SystemExit(f"[ERROR] {var_name} is required but missing or empty")
        return []

    try:
        data = json.loads(raw)
    except json.JSONDecodeError as e:
        raise SystemExit(f"[ERROR] Invalid JSON in {var_name}: {e}\nValue: {raw}")

    return data if data else []


def build_hosts(entries: List[Dict[str, Any]]) -> Dict[str, Dict[str, Any]]:
    hosts = {}

    for e in entries:
        ip = e["private"]

        hosts[ip] = {
            "ansible_host": e["public"],
            "k3s_node_ip": e["private"],
        }

    return hosts


def build_host_list(entries: List[Dict[str, Any]]) -> List[str]:
    return [e["private"] for e in entries]


def get_inventory() -> Dict[str, Any]:
    servers = load_json_env("K3S_SERVERS", required=True)
    agents = load_json_env("K3S_AGENTS", required=False)

    server_hosts = build_hosts(servers)
    agent_hosts = build_hosts(agents)

    return {
        "_meta": {
            "hostvars": {
                **server_hosts,
                **agent_hosts
            }
        },

        "k3s_cluster": {
            "children": ["server", "agent"]
        },

        "server": {
            "hosts": build_host_list(servers),

            "vars": {
                "api_endpoint": servers[0]["private"],

                "extra_server_args": (
                    "--node-ip={{ k3s_node_ip }} "
                    "--advertise-address={{ k3s_node_ip }} "
                    "--disable traefik "
                    "--disable servicelb "
                )
            }
        },

        "agent": {
            "hosts": build_host_list(agents),

            "vars": {
                "extra_agent_args": (
                    "--node-ip={{ k3s_node_ip }}"
                )
            }
        }
    }


if __name__ == "__main__":
    try:
        print(json.dumps(get_inventory(), indent=2))
    except SystemExit as e:
        print(str(e), file=sys.stderr)
        sys.exit(1)