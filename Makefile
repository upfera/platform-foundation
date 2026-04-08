INVENTORY          = ansible/inventories/inventory.yaml
CLUSTER_INVENTORY  = ansible/inventories/cluster.yaml
BOOTSTRAP_PLAYBOOK = ansible/00-init.yml
CLUSTER_PLAYBOOK   = ansible/10-cluster.yml
WRAPPER            = ./ansiblew

.PHONY: bootstrap vps local lint

bootstrap:
	$(WRAPPER) -i $(INVENTORY) -i $(CLUSTER_INVENTORY) -l vps $(BOOTSTRAP_PLAYBOOK)

vps:
	$(WRAPPER) -i $(INVENTORY) -i $(CLUSTER_INVENTORY) -l vps $(CLUSTER_PLAYBOOK)

local:
	$(WRAPPER) -i $(INVENTORY) -l local --tags cluster $(CLUSTER_PLAYBOOK)

lint:
	$(WRAPPER) ansible-lint .