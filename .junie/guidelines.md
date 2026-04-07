# 📘 Upfera Foundation: Development Guidelines

This document defines the **strict engineering standards** for the `platform-foundation` project.

The goal is simple:
👉 **clean, predictable, production-grade Ansible**
👉 **zero overengineering**
👉 **rock-star level execution quality**

---

## 🧠 0. Core Engineering Principles

* Write code like a **senior platform engineer**, not a framework builder.
* Prefer **clarity over abstraction**.
* Prefer **explicit behavior over magic**.
* Every task must be **idempotent**.
* Every decision must be **predictable**.

🚫 DO NOT:

* redesign architecture
* introduce new layers
* modify wrappers (e.g. `ansiblew`)
* add unnecessary abstractions

---

## 🏗️ 1. Scope of Responsibility

You are responsible ONLY for:

* Ansible playbooks (`site.yaml`)
* Ansible roles
* Ansible variables and structure

🚫 You are NOT allowed to:

* modify `ansiblew`
* change CLI behavior
* introduce new execution flows
* redesign environment handling

---

## ⚙️ 2. Execution Model (Fixed)

The system already provides:

* environment detection (WSL vs VPS)
* SSH handling
* Python virtual environment
* Ansible execution

👉 Assume everything outside Ansible is **correct and untouchable**

---

## 🧩 3. Playbook Design

### Single entrypoint (MANDATORY)

```text
ansible/site.yaml
```

* There must be **exactly one entrypoint**
* No alternative playbooks (no `bootstrap.yaml`, no variants)

---

## 🔁 4. Bootstrap Model

Bootstrap is controlled ONLY by variable:

```yaml
bootstrap: true | false
```

### Behavior:

* `bootstrap=true`

    * executed ONLY on VPS
    * connects as root
    * prepares system (user, sudo, ssh)

* `bootstrap=false`

    * assumes system is already prepared
    * connects as target user

---

## 🚫 Hard Rules

* Bootstrap MUST NOT run on local (WSL)
* Bootstrap MUST be isolated in a role
* No bootstrap logic outside that role

---

## 🧱 5. Role Structure

Use clean, minimal roles:

```text
roles/
  user_setup/
  base/
  security/
```

### Rules:

* Each role has **one responsibility**
* No cross-role logic
* No hidden side effects

---

## 👤 6. User Model

### Local (WSL)

* Use current system user
* NEVER create users
* NEVER modify SSH
* NEVER touch sudoers unless explicitly required

---

### VPS

* Use configurable user:

```yaml
ops_user: ops
```

* Bootstrap creates this user ONLY when needed

---

## 🔐 7. Sudo Model

* Use `become: true`
* Use `sudo`
* Avoid password prompts after bootstrap

---

## 📦 8. Package Management

Use:

```yaml
package:
  name: ...
```

NOT:

* `apt` (unless absolutely required)
* OS-specific assumptions

### Rules:

* Keep base packages minimal
* Do NOT install Python/system tooling unnecessarily
* Do NOT assume clean system

---

## 🌍 9. Environment Parity

All roles MUST work in:

### Local (WSL)

```yaml
ansible_connection: local
```

### VPS

```yaml
ansible_connection: ssh
```

👉 Same playbook must work in both cases without branching chaos

---

## 🧼 10. Code Style

* No comments inside YAML
* Names must explain intent
* Tasks must be readable without explanation

### Example:

✔ Good:

```yaml
- name: Ensure target user exists
```

❌ Bad:

```yaml
# create user if not exists
```

---

## 🚀 11. Idempotency (CRITICAL)

Every task must:

* be safe to run multiple times
* not recreate existing resources
* not produce side effects on re-run

---

## 🧪 12. What “Rock Star Code” Means Here

* minimal
* predictable
* composable
* production-ready
* no hacks
* no magic
* no unnecessary flexibility

---

## ❌ Anti-Patterns (Forbidden)

* Multiple playbooks for same flow
* Conditional chaos (`when` everywhere)
* Mixing local and VPS logic randomly
* Installing unnecessary packages
* Managing runtime (venv, python) inside Ansible
* Modifying execution wrappers

---

## 🏁 Goal

Deliver a system that:

* works the same on WSL and VPS
* supports bootstrap and normal runs
* is fully idempotent
* is easy to reason about
* behaves like a **real production platform**

---

## 💬 Final Rule

> If it feels “clever”, it’s probably wrong.
> If it feels boring and obvious, it’s correct.
