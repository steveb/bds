ALL_PROJ=
WORKING_SETS= \
devstack

include *.mk

REMOTE=origin
GITURL=https://github.com/
DEVSTACK_DIR=../devstack-dev

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
