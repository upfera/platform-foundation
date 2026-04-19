# platform-foundation

This project automates the setup of production-grade Kubernetes clusters (k3s) on VPS or local environments, focusing on a robust, private foundation.

## 🌐 Infrastructure Context & Goals

The project aims to build a production-grade Kubernetes platform foundation using K3s.

### 🏗️ Topology
* There are **3 VPS nodes** forming the cluster.
* Role distribution: **1 Control-plane** and **2 Workers**.
* Infrastructure is treated as **dynamic**; nodes are defined via environment variables:
  - `K3S_SERVERS`
  - `K3S_AGENTS`

### 📋 Node Definition Format
Nodes are passed as JSON arrays of objects. **IPs must never be hardcoded in the codebase.**

Example `K3S_SERVERS` / `K3S_AGENTS`:
```json
[
  {"name":"fsn-01","public":"1.2.3.4","private":"10.0.0.101"},
  {"name":"fsn-02","public":"1.2.3.5","private":"10.0.0.102"},
  {"name":"fsn-03","public":"1.2.3.6","private":"10.0.0.103"}
]
```

### 🕸️ Networking Model
* **Kubernetes Private Network:** `10.0.0.0/16` (Hetzner Private Network).
* **WireGuard VPN Network:** `10.200.0.0/24`.
* **VPN Purpose:** Administrative access only.
* **Security:** Kubernetes API (`6443`) is NOT publicly exposed; it is accessible ONLY via the VPN.

### 🔐 Access Model
* **kubectl access** is only possible after connecting to the WireGuard VPN.
* Once connected, the cluster is accessed via **private IPs** (`10.0.0.x`) or **internal DNS**.
* **Public Load Balancer** (if used) is strictly for application traffic (`80`/`443`), never for the Kubernetes API.

## 🎯 Project Goals
The goal is simple:
👉 **clean, predictable, production-grade Ansible**
👉 **zero overengineering**
👉 **rock-star level execution quality**

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
- `K3S_SERVERS`: JSON array of server nodes (see Topology).
- `K3S_AGENTS`: JSON array of agent nodes (see Topology).
- `K3S_TOKEN`: Secret token for the cluster.
- `K3S_VERSION`: Version of k3s to install (default: `v1.31.12+k3s1`).

### MicroK8s
- `MICROK8S_HOST`: IP address of the MicroK8s host (default: `192.168.1.20`).
- `MICROK8S_CHANNEL`: MicroK8s snap channel (default: `1.33/stable`).

## Inventories

The `ansible/inventories` directory contains sample static inventories for different environments and clusters. It is organized by service/role:

- `bootstrap/`: Initial system preparation.
- `k3s/`: K3s cluster inventories (`local.yaml`, `remote.yaml`).
- `microk8s/`: MicroK8s cluster inventories.
- `vpn/`: WireGuard VPN inventories.

Each directory typically contains:
- `local.yaml`: For local development (WSL, local VMs).
- `remote.yaml`: For remote VPS environments.
- `group_vars/`: Environment-specific variables.

These are **sample inventories**. In production, values are typically injected via environment variables or external infrastructure sources.

To run a playbook with a specific inventory:
```bash
ansible-playbook -i ansible/inventories/k3s/remote.yaml ansible/playbooks/k3s.yml
```
