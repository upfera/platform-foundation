WRAPPER := ./ansiblew

INVENTORY_DIR := ansible/inventories
PLAYBOOK_DIR := ansible/playbooks

.PHONY: k3s microk8s bootstrap vpn lint

# ----------------------------
# helper: inventory resolver
# ----------------------------
define inventory
$(INVENTORY_DIR)/$(1)/$(2).yaml
endef

# ----------------------------
# runner
# ----------------------------
define run
	$(WRAPPER) -i $(call inventory,$(1),$(2)) $(3) $(PLAYBOOK_DIR)/$(1).yml
endef

# ----------------------------
# targets
# ----------------------------

k3s:
	$(call run,k3s,$(word 2,$(MAKECMDGOALS)),-e playbook_name=$(PLAYBOOK))

microk8s:
	$(call run,microk8s,$(word 2,$(MAKECMDGOALS)),)

bootstrap:
	$(call run,bootstrap,$(word 2,$(MAKECMDGOALS)),)

vpn:
	$(call run,vpn,$(word 2,$(MAKECMDGOALS)),)

lint:
	$(WRAPPER) ansible-lint .