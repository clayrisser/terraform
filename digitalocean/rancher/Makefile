.PHONY: init
init: .env
	@source ./.env && terraform init \
	 -backend-config="access_key=$$TF_VAR_digitalocean_access_key" \
	 -backend-config="secret_key=$$TF_VAR_digitalocean_secret_key"
.terraform/terraform.tfstate:
	@$(MAKE) -s init

.PHONY: apply
apply: .env .terraform/terraform.tfstate
	@source ./.env && terraform apply

.PHONY: env
env:
	@cp example.env .env
.env:
	@$(MAKE) -s env

.PHONY: destroy
destroy: .terraform/terraform.tfstate
	@source ./.env && terraform destroy
