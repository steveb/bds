HEAT_DIR=../heat
#HEAT_DISTRO=F16
HEAT_DISTRO=F17

#HEAT_FLAVOR=t1.micro
HEAT_FLAVOR=m1.large

#HEAT_TEMPLATE=WordPress_Single_Instance_With_EIP.template
#HEAT_CREATE_PARAMS=InstanceType=$(HEAT_FLAVOR);DBUsername=wp;DBPassword=verybadpassword;KeyName=heat_key;LinuxDistribution=$(HEAT_DISTRO)

HEAT_TEMPLATE=WordPress_Single_Instance.template
HEAT_CREATE_PARAMS=InstanceType=$(HEAT_FLAVOR);DBUsername=wp;DBPassword=verybadpassword;KeyName=heat_key;LinuxDistribution=$(HEAT_DISTRO)

#HEAT_TEMPLATE=S3_Single_Instance.template
#HEAT_CREATE_PARAMS=

heat-flavor:
	cd $(HEAT_DIR) && tools/nova_create_flavors.sh

heat-keypair:
	nova keypair-add --pub_key ~/.ssh/id_rsa.pub heat_key

heat-secomp:
	nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
	nova secgroup-create ssh "SSH server"
	nova secgroup-add-rule ssh tcp 22 22 0.0.0.0/0
	nova secgroup-create http "HTTP web server"
	nova secgroup-add-rule http tcp 80 80 0.0.0.0/0
	nova secgroup-create https "HTTPS secure web server"
	nova secgroup-add-rule https tcp 443 443 0.0.0.0/0

heat-create:
	cd $(HEAT_DIR) && heat -d create foo --template-file=templates/$(HEAT_TEMPLATE) \
	--parameters="$(HEAT_CREATE_PARAMS)"

heat-all: heat-flavor heat-keypair heat-create