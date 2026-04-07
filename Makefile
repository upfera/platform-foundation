INVENTORY = ansible/inventories/inventory.yaml
CONSTRUCTED = ansible/inventories/constructed.yaml
BOOTSTRAP = ansible/bootstrap.yml
SITE      = ansible/site.yaml
WRAPPER   = ./ansiblew

.PHONY: bootstrap vps local lint

bootstrap:
	$(WRAPPER) -i $(INVENTORY) -i '$(VPS_IPS)' -i $(CONSTRUCTED) -l vps $(BOOTSTRAP)

vps:
	$(WRAPPER) -i $(INVENTORY) -i '$(VPS_IPS)' -i $(CONSTRUCTED) -l vps $(SITE)

local:
	$(WRAPPER) -i $(INVENTORY) -l local --tags cluster $(SITE)

lint:
	$(WRAPPER) ansible-lint .