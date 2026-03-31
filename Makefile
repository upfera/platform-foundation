WRAPPER 		:= ./ansiblew

LOCAL_INV 		:= ansible/inventories/local.yaml
BOOTSTRAP_INV	:= ansible/inventories/bootstrap.py
K3S_INV 		:= ansible/inventories/k3s.py
MICROK8S_INV 	:= ansible/inventories/microk8s.py

.PHONY: k3s microk8s local-k3s local-microk8s bootstrap lint

k3s:
	$(WRAPPER) -i $(K3S_INV) -e playbook_name=${PLAYBOOK} ansible/k3s.yml

local-k3s:
	$(WRAPPER) -i $(LOCAL_INV) -e playbook_name=${PLAYBOOK} ansible/k3s.yml

microk8s:
	$(WRAPPER) -i $(MICROK8S_INV) ansible/microk8s.yml

local-microk8s:
	$(WRAPPER) -i $(LOCAL_INV) ansible/microk8s.yml

bootstrap:
	@$(WRAPPER) -i $(BOOTSTRAP_INV) ansible/bootstrap.yml

lint:
	$(WRAPPER) ansible-lint .