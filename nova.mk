#NOVA_IMAGE=F16-x86_64-cfntools
NOVA_IMAGE=cirros-0.3.0-i386-disk

NOVA_FLAVOR=m1.tiny
#NOVA_FLAVOR=m1.small

NOVA_NAME=instance-`date +"%H%M-%S"`

nova-keypair:
	nova keypair-add --pub_key ~/.ssh/id_rsa.pub nova_key

nova-boot:
	nova boot --flavor $(NOVA_FLAVOR) --image $(NOVA_IMAGE) --key-name nova_key $(NOVA_NAME)
