INVENTORY = ansible/inventories/inventory.yaml
BOOTSTRAP = ansible/bootstrap.yml
SITE      = ansible/site.yaml
WRAPPER   = ./ansiblew

.PHONY: bootstrap deploy local lint

bootstrap:
	$(WRAPPER) -i $(INVENTORY) $(BOOTSTRAP)

deploy:
	$(WRAPPER) -i $(INVENTORY) $(SITE)

local:
	$(WRAPPER) -i $(INVENTORY) -l local $(SITE)

lint:
	$(WRAPPER) ansible-lint .