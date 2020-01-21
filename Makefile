AWS_ACCESS_KEY_ID := $(shell export AWS_PROFILE=$(AWS_PROFILE) && python3 aws_credentials.py aws_access_key_id)
AWS_PROFILE := siliconhills
AWS_SECRET_ACCESS_KEY := $(shell export AWS_PROFILE=$(AWS_PROFILE) && python3 aws_credentials.py aws_secret_access_key)
CLUSTER_ID := $(shell read -p "cluster id: " INPUT && echo $INPUT)
COMMAND := $(shell read -p "command: " INPUT && echo $INPUT)
PLATFORM := aws
TARGETS :=

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
orch-destroy: orch-init
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/orch && \
		terraform destroy

.PHONY: nodes-push
nodes-push: nodes-init
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/nodes && \
		terraform state push .terraform/terraform.tfstate

.PHONY: nodes
nodes: nodes-refresh
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/nodes && \
		terraform apply \
      -var "aws_access_key=$(AWS_ACCESS_KEY_ID)" \
      -var "aws_secret_key=$(AWS_SECRET_ACCESS_KEY)" \
      -var "cluster_id=$(CLUSTER_ID)" \
      -var "command=$(COMMAND)"

.PHONY: nodes-refresh
nodes-refresh: nodes-init
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/nodes && \
		terraform refresh \
      -var "aws_access_key=$(AWS_ACCESS_KEY_ID)" \
      -var "aws_secret_key=$(AWS_SECRET_ACCESS_KEY)" \
      -var "cluster_id=$(CLUSTER_ID)" \
      -var "command=$(COMMAND)"

.PHONY: nodes-plan
nodes-plan: nodes-refresh
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/nodes && \
		terraform plan \
      -var "aws_access_key=$(AWS_ACCESS_KEY_ID)" \
      -var "aws_secret_key=$(AWS_SECRET_ACCESS_KEY)" \
      -var "cluster_id=$(CLUSTER_ID)" \
      -var "command=$(COMMAND)"

.PHONY: nodes-init
nodes-init:
	@export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/nodes && \
		terraform init

.PHONY: nodes-destroy
nodes-destroy: nodes-init
	export AWS_PROFILE=$(AWS_PROFILE) && cd $(PLATFORM)/nodes && \
		terraform destroy $(TARGETS) \
      -var "aws_access_key=$(AWS_ACCESS_KEY_ID)" \
      -var "aws_secret_key=$(AWS_SECRET_ACCESS_KEY)" \
      -var "cluster_id=" \
      -var "command="
