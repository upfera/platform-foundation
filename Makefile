STATIC    = ansible/inventories/static.yaml
DYNAMIC   = ansible/inventories/dynamic.yaml
BOOTSTRAP = ansible/00-init.yml
CLUSTER   = ansible/10-cluster.yml
WRAPPER   = ./ansiblew

.PHONY: bootstrap vps local lint

bootstrap:
	$(WRAPPER) -i $(STATIC) -i '$(VPS_IPS)' -i $(DYNAMIC) -l vps $(BOOTSTRAP)

vps:
	$(WRAPPER) -i $(STATIC) -i '$(VPS_IPS)' -i $(DYNAMIC) -l vps $(CLUSTER)

local:
	$(WRAPPER) -i $(STATIC) -l local --tags cluster $(CLUSTER)

lint:
	$(WRAPPER) ansible-lint .