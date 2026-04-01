INVENTORY = ansible/inventories/inventory.yaml
ANSIBLE   = ./ansiblew -i $(INVENTORY)

export ANSIBLE_SSH_ARGS="-o IdentitiesOnly=yes"

.PHONY: local vps bootstrap-vps lint syntax-check

local:
	$(ANSIBLE) -l local ansible/site.yaml

vps:
	$(ANSIBLE) -l vps ansible/site.yaml

bootstrap-vps:
	$(ANSIBLE) -l vps ansible/bootstrap.yaml -e "bootstrap=true"

lint:
	ansible-lint ansible/site.yaml ansible/bootstrap.yaml

syntax-check:
	ansible-playbook --syntax-check ansible/site.yaml -i $(INVENTORY)
	ansible-playbook --syntax-check ansible/bootstrap.yaml -i $(INVENTORY)