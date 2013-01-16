HEAT_DIR=../heat
#HEAT_DISTRO=F16
#HEAT_DISTRO=F17
HEAT_DISTRO=U10
HEAT_BIN=heat
#HEAT_BIN=../heat/bin/heat-cfn

#HEAT_FLAVOR=t1.micro
HEAT_FLAVOR=m1.large
#HEAT_FLAVOR=m1.small

#HEAT_TEMPLATE=WordPress_Single_Instance_With_EIP.template
#HEAT_CREATE_PARAMS=InstanceType=$(HEAT_FLAVOR);DBUsername=wp;DBPassword=verybadpassword;KeyName=heat_key;LinuxDistribution=$(HEAT_DISTRO)

#HEAT_TEMPLATE=WordPress_Single_Instance_With_Quantum.template
#HEAT_CREATE_PARAMS=InstanceType=$(HEAT_FLAVOR);DBUsername=wp;DBPassword=verybadpassword;KeyName=heat_key;LinuxDistribution=$(HEAT_DISTRO)

#HEAT_TEMPLATE=WordPress_Single_Instance.template
HEAT_TEMPLATE=WordPress_Single_Instance_deb.template
#HEAT_TEMPLATE=WordPress_With_LB.template
#HEAT_TEMPLATE=WordPress_Single_Instance_With_HA.template
#HEAT_TEMPLATE=WordPress_Single_Instance_With_IHA.template
HEAT_CREATE_PARAMS=InstanceType=$(HEAT_FLAVOR);DBUsername=wp;DBPassword=verybadpassword;KeyName=heat_key;LinuxDistribution=$(HEAT_DISTRO)

#HEAT_TEMPLATE=MySQL_Single_Instance.template
#HEAT_CREATE_PARAMS=InstanceType=$(HEAT_FLAVOR);DBUsername=wp;DBPassword=verybadpassword;DBRootPassword=root;DBName=foodb;KeyName=heat_key;LinuxDistribution=$(HEAT_DISTRO)

#HEAT_TEMPLATE=S3_Single_Instance.template
#HEAT_CREATE_PARAMS=

#HEAT_TEMPLATE=Quantum.yaml
#HEAT_CREATE_PARAMS=

#HEAT_TEMPLATE=Quantum_floating.template
#QUANTUM_EXTERNAL_NETWORK=$(shell quantum net-list -F id  -- --name=nova | awk "NR==4" | cut -d' ' -f2)
#QUANTUM_INTERNAL_NETWORK=$(shell quantum net-list -F id  -- --name=private | awk "NR==4" | cut -d' ' -f2)
#QUANTUM_SUBNET=$(shell quantum subnet-list -F id  -- --cidr=10.0.0.0/24 | awk "NR==4" | cut -d' ' -f2)
#HEAT_CREATE_PARAMS=external_network=$(QUANTUM_EXTERNAL_NETWORK);internal_network=$(QUANTUM_INTERNAL_NETWORK);internal_subnet=$(QUANTUM_SUBNET)

heat-keypair:
	nova keypair-add heat_key > heat_key.priv
	chmod 600 heat_key.priv

heat-secomp:
	nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
	nova secgroup-create ssh "SSH server"
	nova secgroup-add-rule ssh tcp 22 22 0.0.0.0/0
	nova secgroup-create http "HTTP web server"
	nova secgroup-add-rule http tcp 80 80 0.0.0.0/0
	nova secgroup-create https "HTTPS secure web server"
	nova secgroup-add-rule https tcp 443 443 0.0.0.0/0

heat-create:
	$(HEAT_BIN) stack-create teststack --template-file=$(HEAT_DIR)/templates/$(HEAT_TEMPLATE) \
	--parameters="$(HEAT_CREATE_PARAMS)"

heat-all: heat-flavor heat-keypair heat-create
