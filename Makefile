INVENTORY = ansible/inventories/inventory.yaml
PLAYBOOK  = ansible/site.yaml

ANSIBLE_LOCAL = ./ansiblew -i $(INVENTORY)
ANSIBLE_VPS   = ansible-playbook -i $(INVENTORY)

.PHONY: local vps base firewall cluster lint syntax-check

local:
	$(ANSIBLE_LOCAL) -l local --skip-tags bootstrap $(PLAYBOOK)

vps:
	$(ANSIBLE_VPS) -l vps $(PLAYBOOK)

lint:
	ansible-lint $(PLAYBOOK)

syntax-check:
	$(ANSIBLE_VPS) --syntax-check $(PLAYBOOK)