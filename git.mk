STATUS := $(patsubst %,status-%,$(ALL_PROJ))
status: $(STATUS)
$(STATUS):
	cd ../$(subst status-,,$@) && git status || true

PULL := $(patsubst %,pull-%,$(ALL_PROJ))
pull: $(PULL)
$(PULL):
	cd ../$(subst pull-,,$@) && git pull --tags $(REMOTE) master

MERGE := $(patsubst %,merge-%,$(ALL_PROJ))
merge: $(MERGE)
$(MERGE):
	cd ../$(subst merge-,,$@) && git merge $(REMOTE)/master

FETCH := $(patsubst %,fetch-%,$(ALL_PROJ))
fetch: $(FETCH)
$(FETCH):
	cd ../$(subst fetch-,,$@) && git fetch --tags $(REMOTE)

INCOMING := $(patsubst %,incoming-%,$(ALL_PROJ))
incoming: $(INCOMING)
$(INCOMING):
	cd ../$(subst incoming-,,$@) && git $(CHANGECMD) -p HEAD..$(REMOTE)/master

OUTGOING := $(patsubst %,outgoing-%,$(ALL_PROJ))
outgoing: $(OUTGOING)
$(OUTGOING):
	cd ../$(subst outgoing-,,$@) && git $(CHANGECMD) $(REMOTE)/master..HEAD

PUSH := $(patsubst %,push-%,$(ALL_PROJ))
push: $(PUSH)
$(PUSH):
	cd ../$(subst push-,,$@) && git push --tags $(REMOTE) master

GITGUI := $(patsubst %,gitgui-%,$(ALL_PROJ))
gitgui: $(GITGUI)
$(GITGUI):
	cd ../$(subst gitgui-,,$@) && git gui

MELD := $(patsubst %,meld-%,$(ALL_PROJ))
meld: $(MELD)
$(MELD):
	cd ../$(subst meld-,,$@) && meld ./

GITG := $(patsubst %,gitg-%,$(ALL_PROJ))
gitg: $(GITG)
$(GITG):
	cd ../$(subst gitg-,,$@) && gitg
