local:
	./ansiblew -i ansible/inventories/inventory.yaml -l local ansible/site.yaml

vps:
	./ansiblew -i ansible/inventories/inventory.yaml -l vps ansible/site.yaml

bootstrap-vps:
	./ansiblew -i ansible/inventories/inventory.yaml -l vps ansible/bootstrap.yaml -e "bootstrap=true"

lint:
	ansible-lint ansible/site.yaml ansible/bootstrap.yaml

syntax-check:
	ansible-playbook --syntax-check ansible/site.yaml -i ansible/inventories/inventory.yaml
	ansible-playbook --syntax-check ansible/bootstrap.yaml -i ansible/inventories/inventory.yaml