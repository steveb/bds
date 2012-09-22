ALL_PROJ += ceilometer \
cinder \
glance \
heat \
horizon \
keystone \
nova \
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

COVER_PACKAGE=
NOSE_PATH=

TOX := $(patsubst %,tox-%,$(ALL_PROJ))
tox: $(TOX)
$(TOX):
	cd ../$(subst tox-,,$@) && tox

NOSE := $(patsubst %,nose-%,$(ALL_PROJ))
nose: $(NOSE)
$(NOSE):
	cd ../$(subst nose-,,$@) && nosetests $(NOSE_PATH)

COVER := $(patsubst %,cover-%,$(ALL_PROJ))
cover: $(COVER)
$(COVER):
	cd ../$(subst cover-,,$@) && \
	nosetests --with-coverage --cover-html --cover-package=$(COVER_PACKAGE) $(NOSE_PATH) && \
	google-chrome ../$(subst cover-,,$@)/cover/index.html 
