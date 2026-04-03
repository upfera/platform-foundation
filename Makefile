INVENTORY = ansible/inventories/inventory.yaml
PLAYBOOK  = ansible/site.yaml

ANSIBLE_WRAPPER = ./ansiblew -i $(INVENTORY)

.PHONY: local vps lint syntax-check

local:
	$(ANSIBLE_WRAPPER) -l local --tags cluster $(PLAYBOOK)

vps:
	$(ANSIBLE_VPS) -l vps -e "ansible_user=$(ANSIBLE_USER)" --private-key $(OPS_KEY) --private-key $(ROOT_KEY) --ssh-common-args='-o IdentitiesOnly=yes -o StrictHostKeyChecking=no' -e "ansible_user_public_key_file=$(PUB_KEY)" $(PLAYBOOK)

lint:
	ansible-lint $(PLAYBOOK)

syntax-check:
	$(ANSIBLE_WRAPPER) --syntax-check $(PLAYBOOK)