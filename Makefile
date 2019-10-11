PLATFORM := aws
AWS_PROFILE := siliconhills
AWS_ACCESS_KEY_ID := $(shell python3 aws_credentials.py aws_access_key_id)
AWS_SECRET_ACCESS_KEY := $(shell python3 aws_credentials.py aws_secret_access_key)

.PHONY: all
all:

.PHONY: clean
clean:
	@git clean -fXd

.PHONY: orch
orch: orch-init
	@cd $(PLATFORM)/orch && \
		terraform apply

.PHONY: orch-push
orch-push: orch-init
	@cd $(PLATFORM)/orch && \
		terraform state push .terraform/terraform.tfstate

.PHONY: orch-init
orch-init:
	@cd $(PLATFORM)/orch && \
		terraform init

.PHONY: orch-destroy
orch-destroy:
	@cd $(PLATFORM)/orch && \
		terraform destroy

.PHONY: nodes-push
nodes-push: nodes-init
	@cd $(PLATFORM)/nodes && \
		terraform state push .terraform/terraform.tfstate

.PHONY: nodes
nodes: nodes-init
	@cd $(PLATFORM)/nodes && \
		terraform apply \
      -var "aws_access_key=$(AWS_ACCESS_KEY_ID)" \
      -var "aws_secret_key=$(AWS_SECRET_ACCESS_KEY)"

.PHONY: nodes-init
nodes-init:
	@cd $(PLATFORM)/nodes && \
		terraform init

.PHONY: nodes-destroy
nodes-destroy:
	@cd $(PLATFORM)/nodes && \
		terraform destroy \
      -var "aws_access_key=$(AWS_ACCESS_KEY_ID)" \
      -var "aws_secret_key=$(AWS_SECRET_ACCESS_KEY)" \
      -var "command="
