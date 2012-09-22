stack:
	cd $(DEVSTACK_DIR) && ./stack.sh

unstack:
	cd $(DEVSTACK_DIR) && ./unstack.sh

screen:
	screen -r

source-heat:
	echo "pushd $(DEVSTACK_DIR) && source openrc heat service && popd"
