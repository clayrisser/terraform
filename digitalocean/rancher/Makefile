.PHONY: init
init:
	@source ./.env && terraform init \
	 -backend-config="access_key=$$TF_VAR_access_key" \
	 -backend-config="secret_key=$$TF_VAR_secret_key"
.terraform/terraform.tfstate:
	@$(MAKE) -s init

.PHONY: apply
apply: .terraform/terraform.tfstate
	@source ./.env && terraform apply
