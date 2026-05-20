# upfera.foundation (Ansible Collection)

This collection provides the core provisioning logic for the Upfera Platform. It is designed to be environment-agnostic and reusable.

## 🏗️ Architecture

- **platform-foundation (this repo):** Defines "HOW" to provision. Contains roles and playbooks.
- **tenant repo:** Defines "WHERE" to provision. Contains inventories, environment configurations, and secrets.
- **gh-reusable-workflows:** Defines "HOW TO RUN" Ansible in CI/CD.

## 🧩 Included Playbooks

The following playbooks are exposed via the collection:

- `upfera.foundation.bootstrap`: Initial system preparation (user setup, security, SSH).
- `upfera.foundation.k3s`: K3s cluster installation and orchestration.
- `upfera.foundation.microk8s`: MicroK8s cluster setup.
- `upfera.foundation.vpn`: WireGuard VPN configuration.

## 🚀 Usage

In your tenant repository, define a `requirements.yml`:

```yaml
collections:
  - name: https://github.com/upfera/platform-foundation.git
    type: git
    version: main
```

Install the collection:
```bash
ansible-galaxy collection install -r requirements.yml
```

Run a playbook:
```bash
ansible-playbook upfera.foundation.bootstrap -i inventory.yaml
```

## 🧪 Testing with Docker

You can test the playbooks using Docker containers as target hosts.

### Example Test Inventory (`inventory.test.yaml`)

```yaml
all:
  hosts:
    test-node-1:
      ansible_host: 127.0.0.1
      ansible_port: 2222
      ansible_user: root
      ansible_ssh_private_key_file: ~/.ssh/id_rsa
  children:
    bootstrap:
      hosts:
        test-node-1:
    microk8s_cluster:
      hosts:
        test-node-1:
```

### Running Tests

1. Start a systemd-enabled Docker container:
```bash
docker run -d --name test-node-1 -p 2222:22 -v /sys/fs/cgroup:/sys/fs/cgroup:ro --privileged jrei/systemd-ubuntu:22.04
```

2. Run the playbook:
```bash
ansible-playbook upfera.foundation.bootstrap -i inventory.test.yaml
```

## 🔐 Configuration

Logic is driven by variables. Ensure your inventory or `group_vars` provide the necessary context.
Refer to `roles/*/defaults/main.yml` for available configuration options.
