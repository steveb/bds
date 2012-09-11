HEAT_DIR=../heat
HEAT_DISTRO=F16
HEAT_FLAVOR=t1.micro



#HEAT_TEMPLATE=WordPress_Single_Instance.template
#HEAT_CREATE_PARAMS=InstanceType=$(HEAT_FLAVOR);DBUsername=wp;DBPassword=verybadpassword;KeyName=heat_key;LinuxDistribution=$(HEAT_DISTRO)

HEAT_TEMPLATE=S3_Single_Instance.template
HEAT_CREATE_PARAMS=

heat-flavor:
	cd $(HEAT_DIR) && tools/nova_create_flavors.sh

heat-keypair:
	nova keypair-add --pub_key ~/.ssh/id_rsa.pub heat_key

heat-create:
	cd $(HEAT_DIR) && heat -d create foo --template-file=templates/$(HEAT_TEMPLATE) \
	--parameters="$(HEAT_CREATE_PARAMS)"

heat-all: heat-flavor heat-keypair heat-create