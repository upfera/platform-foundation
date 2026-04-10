WRAPPER 		:= ./ansiblew

LOCAL_INV 		:= ansible/inventories/local.yaml
BOOTSTRAP_INV	:= ansible/inventories/bootstrap.yaml
K3S_INV 		:= ansible/inventories/k3s_cluster.yaml
MICROK8S_INV 	:= ansible/inventories/microk8s_cluster.yaml

.PHONY: k3s microk8s local-k3s local-microk8s bootstrap lint

k3s:
	$(WRAPPER) -i $(K3S_INV) ansible/k3s.yml

microk8s:
	$(WRAPPER) -i $(MICROK8S_INV) ansible/microk8s.yml

local-k3s:
	$(WRAPPER) -i $(LOCAL_INV) ansible/k3s.yml

local-microk8s:
	$(WRAPPER) -i $(LOCAL_INV) ansible/microk8s.yml

bootstrap:
	$(WRAPPER) -i $(BOOTSTRAP_INV) ansible/bootstrap.yml

lint:
	$(WRAPPER) ansible-lint .