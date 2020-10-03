.PHONY: init
init: .env
	@. ./.env && terraform init \
	 -backend-config="access_key=$$TF_VAR_digitalocean_access_key" \
	 -backend-config="secret_key=$$TF_VAR_digitalocean_secret_key"
	-@. ./.env && terraform state push .terraform/terraform.tfstate 2>/dev/null || true
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

.PHONY: destroy
destroy: .terraform/terraform.tfstate
	@. ./.env && terraform destroy
