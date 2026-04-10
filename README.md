# platform-foundation

This project automates the setup of Kubernetes clusters (k3s or MicroK8s) on VPS or local environments.

## Quick Start

### Orchestration via Makefile

The Makefile is the primary orchestrator for all tasks.

```bash
# Bootstrap VPS and install k3s (default)
make all

# Bootstrap only
make bootstrap

# Install specific cluster type (VPS)
make k3s
make microk8s

# Install specific cluster type (Local/WSL)
make local-k3s
make local-microk8s
```

## Configuration via Environment Variables

You can configure hosts and cluster settings using environment variables.

### General
- `ANSIBLE_USER`: The user Ansible will use to connect (default: `ops`).
- `PUB_KEY_PATH`: Path to the public key to be added to the target user.

### k3s (default)
- `K3S_SERVER_HOSTS`: IP address of the k3s server (default: `192.168.1.10`).
- `K3S_AGENT_HOSTS`: Comma-separated list of k3s agent IPs (default: `192.168.1.11,192.168.1.12`).
- `K3S_TOKEN`: Secret token for the cluster.
- `K3S_VERSION`: Version of k3s to install (default: `v1.31.12+k3s1`).

### MicroK8s
- `MICROK8S_HOST`: IP address of the MicroK8s host (default: `192.168.1.20`).
- `MICROK8S_CHANNEL`: MicroK8s snap channel (default: `1.33/stable`).

## Inventories

- `ansible/inventories/k3s.py`: Dynamic inventory for k3s using environment variables.
- `ansible/inventories/microk8s.py`: Dynamic inventory for MicroK8s using environment variables.
- `ansible/inventories/local.yaml`: Localhost inventory.
