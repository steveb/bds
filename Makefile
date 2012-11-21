ALL_PROJ += ceilometer \
cinder \
glance \
heat \
horizon \
keystone \
nova \
quantum \
noVNC \
openstack-common \
python-cinderclient \
python-glanceclient \
python-keystoneclient \
python-novaclient \
python-openstackclient \
python-swiftclient \
swift \
swift3

WORKING_SETS= \
devstack

include *.mk

REMOTE=origin
GITURL=https://github.com/
DEVSTACK_DIR=../devstack

USE := $(patsubst %,use-%,$(WORKING_SETS))
use: $(USE)
$(USE):
	ln -sf include/$(subst use-,,$@).mk.txt include-$(subst use-,,$@).mk

UNUSE := $(patsubst %,unuse-%,$(WORKING_SETS))
unuse: $(UNUSE)
$(UNUSE):
	rm -f include-$(subst unuse-,,$@).mk


fin:
	fin
