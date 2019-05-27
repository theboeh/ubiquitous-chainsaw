export TF_VAR_access_key = $(AWS_ACCESS_KEY_ID)
export TF_VAR_secret_key = $(AWS_SECRET_ACCESS_KEY)

.PHONY: clean apply copy_task

copy_task: export ANSIBLE_HOST_KEY_CHECKING = False
copy_task: .tmp/inventory.ini ansible/copy.yaml
	ansible-playbook ansible/copy.yaml -i .tmp/inventory.ini

.tmp/inventory.ini: terraform.tfstate scripts/make_inventory.awk
	terraform output | awk -f scripts/make_inventory.awk > .tmp/inventory.ini

terraform.tfstate apply: .tmp/terraform_init *.tf scripts/localinfo.sh ansible/provision_instance_a.yaml ansible/provision_instance_b.yaml
	terraform apply -auto-approve

.tmp/terraform_init: .tmp/tmp
	terraform init
	@touch .tmp/terraform_init

.tmp/tmp:
	@mkdir -p .tmp
	@touch .tmp/tmp

clean:
	@rm -rf .tmp
	-terraform destroy -auto-approve
	rm terraform.tfstate
	rm -rf .terraform
