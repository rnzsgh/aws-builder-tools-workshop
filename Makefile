
PROFILE ?= test
REGION ?= us-east-1

SUBNET_ID_0 ?= subnet-656b0469
SUBNET_ID_1 ?= subnet-4c5e2729

VPC_ID ?= vpc-fe0b9698

.PHONY: validate-template
validate-template:
	@aws cloudformation validate-template \
  --profile $(PROFILE) \
  --template-body file://stack.cfn.yml

.PHONY: create-stack
create-stack:
	@aws cloudformation create-stack \
  --profile $(PROFILE) \
  --stack-name dev-tools-workshop \
  --region $(REGION) \
  --capabilities CAPABILITY_NAMED_IAM \
	--parameters \
		ParameterKey=SubnetId0,ParameterValue=$(SUBNET_ID_0) \
		ParameterKey=SubnetId1,ParameterValue=$(SUBNET_ID_1) \
		ParameterKey=VpcId,ParameterValue=$(VPC_ID) \
  --template-body file://stack.cfn.yml

.PHONY: update-stack
update-stack:
	@aws cloudformation update-stack \
  --profile $(PROFILE) \
  --stack-name dev-tools-workshop \
  --region $(REGION) \
  --capabilities CAPABILITY_NAMED_IAM \
	--parameters \
		ParameterKey=SubnetId0,ParameterValue=$(SUBNET_ID_0) \
		ParameterKey=SubnetId1,ParameterValue=$(SUBNET_ID_1) \
		ParameterKey=VpcId,ParameterValue=$(VPC_ID) \
  --template-body file://stack.cfn.yml
