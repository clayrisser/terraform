PLATFORM := aws
AWS_PROFILE := siliconhills
AWS_ACCESS_KEY_ID := $(shell export AWS_PROFILE=$(AWS_PROFILE) && python3 aws_credentials.py aws_access_key_id)
AWS_SECRET_ACCESS_KEY := $(shell export AWS_PROFILE=$(AWS_PROFILE) && python3 aws_credentials.py aws_secret_access_key)

.PHONY: all
all:

.PHONY: clean
clean:
	@git clean -fXd

.PHONY: orch
orch: orch-init
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/orch && \
		terraform apply

.PHONY: orch-push
orch-push: orch-init
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/orch && \
		terraform state push .terraform/terraform.tfstate

.PHONY: orch-init
orch-init:
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/orch && \
		terraform init

.PHONY: orch-destroy
orch-destroy:
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/orch && \
		terraform destroy

.PHONY: nodes-push
nodes-push: nodes-init
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/nodes && \
		terraform state push .terraform/terraform.tfstate

.PHONY: nodes
nodes: nodes-init
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/nodes && \
		terraform apply \
      -var "aws_access_key=$(AWS_ACCESS_KEY_ID)" \
      -var "aws_secret_key=$(AWS_SECRET_ACCESS_KEY)"

.PHONY: nodes-init
nodes-init:
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/nodes && \
		terraform init

.PHONY: nodes-destroy
nodes-destroy:
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/nodes && \
		terraform destroy \
      -var "aws_access_key=$(AWS_ACCESS_KEY_ID)" \
      -var "aws_secret_key=$(AWS_SECRET_ACCESS_KEY)" \
      -var "cluster_id=" \
      -var "command="
