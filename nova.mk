#NOVA_IMAGE=F16-x86_64-cfntools
#NOVA_IMAGE=cirros-0.3.0-i386-disk
#NOVA_IMAGE=lucid-server-cloudimg-amd64-disk1
NOVA_IMAGE=quantal-server-cloudimg-amd64-disk1
#NOVA_IMAGE=F17-x86_64-cfntools

#NOVA_FLAVOR=m1.tiny
#NOVA_FLAVOR=m1.small
NOVA_FLAVOR=m1.large

NOVA_NAME=instance-`date +"%H%M-%S"`

nova-keypair:
	nova keypair-add --pub_key ~/.ssh/id_rsa.pub nova_key

nova-boot:
	nova boot --flavor $(NOVA_FLAVOR) --image $(NOVA_IMAGE) --key-name nova_key $(NOVA_NAME)

nova-secgroup:
	nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
	nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
