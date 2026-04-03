INVENTORY = ansible/inventories/inventory.yaml
BOOTSTRAP = ansible/bootstrap.yml
SITE      = ansible/site.yaml
WRAPPER   = ./ansiblew
SSH_USER ?= ops
PUB_KEY  ?= ~/.ssh/id_rsa.pub

.PHONY: bootstrap vps local lint

bootstrap:
	$(WRAPPER) -i $(INVENTORY) -l vps -u $(SSH_USER) -e "ansible_user_public_key_file=$(PUB_KEY)" $(BOOTSTRAP)

vps:
	$(WRAPPER) -i $(INVENTORY) -l vps $(SITE)

local:
	$(WRAPPER) -i $(INVENTORY) -l local --tags cluster $(SITE)

lint:
	$(WRAPPER) ansible-lint .