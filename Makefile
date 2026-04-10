WRAPPER 		:= ./ansiblew

LOCAL_INV 		:= ansible/inventories/local.yaml
BOOTSTRAP_INV	:= ansible/inventories/bootstrap.py
K3S_INV 		:= ansible/inventories/k3s.py
MICROK8S_INV 	:= ansible/inventories/microk8s.py

.PHONY: k3s microk8s local-k3s local-microk8s bootstrap lint

SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

k3s:
	$(WRAPPER) -i $(K3S_INV) ansible/k3s.yml

microk8s:
	$(WRAPPER) -i $(MICROK8S_INV) ansible/microk8s.yml

local-k3s:
	$(WRAPPER) -i $(LOCAL_INV) ansible/k3s.yml

local-microk8s:
	$(WRAPPER) -i $(LOCAL_INV) ansible/microk8s.yml

bootstrap:
	@echo "▶ bootstrap starting"
	@$(WRAPPER) -i $(BOOTSTRAP_INV) ansible/bootstrap.yml || \
	  (echo "❌ bootstrap failed" >&2; exit 1)

lint:
	$(WRAPPER) ansible-lint .