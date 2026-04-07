STATIC    = ansible/inventories/static.yaml
DYNAMIC   = ansible/inventories/dynamic.yaml
SITE      = ansible/site.yaml
WRAPPER   = ./ansiblew

.PHONY: bootstrap vps local lint

bootstrap:
	$(WRAPPER) -i $(STATIC) -i '$(VPS_IPS)' -i $(DYNAMIC) -l vps $(BOOTSTRAP)

vps:
	$(WRAPPER) -i $(STATIC) -i '$(VPS_IPS)' -i $(DYNAMIC) -l vps $(SITE)

local:
	$(WRAPPER) -i $(STATIC) -l local --tags cluster $(SITE)

lint:
	$(WRAPPER) ansible-lint .