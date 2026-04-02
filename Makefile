INVENTORY = ansible/inventories/inventory.yaml
PLAYBOOK  = ansible/site.yaml

# Local execution uses the wrapper
ANSIBLE_LOCAL = ./ansiblew -i $(INVENTORY)

# Remote execution (VPS) uses ansible-playbook directly
# Assumes ansible-playbook is already in the environment (e.g., GitHub Actions or pre-installed)
ANSIBLE_VPS   = ansible-playbook -i $(INVENTORY)

.PHONY: local vps bootstrap-vps lint syntax-check

local:
	$(ANSIBLE_LOCAL) -l local $(PLAYBOOK)

vps:
	$(ANSIBLE_VPS) -l vps $(PLAYBOOK)

bootstrap-vps:
	$(ANSIBLE_VPS) -l vps $(PLAYBOOK) -e "bootstrap=true"

lint:
	ansible-lint $(PLAYBOOK)

syntax-check:
	$(ANSIBLE_VPS) --syntax-check $(PLAYBOOK)