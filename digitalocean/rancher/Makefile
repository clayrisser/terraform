.PHONY: init
init: .env
	@. ./.env && terraform init \
	 -backend-config="access_key=$$TF_VAR_digitalocean_access_key" \
	 -backend-config="secret_key=$$TF_VAR_digitalocean_secret_key"
.terraform/terraform.tfstate:
	@$(MAKE) -s init

.PHONY: apply
apply: .env .terraform/terraform.tfstate
	@. ./.env && terraform apply

.PHONY: env
env:
	@cp example.env .env
.env:
	@$(MAKE) -s env

.PHONY: push
push:
	@. ./.env && terraform state push .terraform/terraform.tfstate

.PHONY: destroy
destroy: .terraform/terraform.tfstate
	@. ./.env && terraform destroy
