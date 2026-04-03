INVENTORY = ansible/inventories/inventory.yaml
PLAYBOOK  = ansible/site.yaml

ANSIBLE_LOCAL = ./ansiblew -i $(INVENTORY)
ANSIBLE_VPS   = ./ansiblew -i $(INVENTORY)

.PHONY: local vps base firewall cluster lint syntax-check

local:
	$(ANSIBLE_LOCAL) -l local --skip-tags bootstrap $(PLAYBOOK)

vps:
	$(ANSIBLE_VPS) -l vps -u $(ANSIBLE_USER) --private-key $(ANSIBLE_USER_PRIVATE_KEY_FILE) -e "ansible_user_private_key_file=$(ANSIBLE_USER_PRIVATE_KEY_FILE)" -e "ansible_user_public_key_file=$(ANSIBLE_USER_PUBLIC_KEY_FILE)" $(PLAYBOOK)

lint:
	ansible-lint $(PLAYBOOK)

syntax-check:
	$(ANSIBLE_VPS) --syntax-check $(PLAYBOOK)