stack:
	sudo yum -y erase rabbitmq-server
	sudo rm -rf /var/lib/rabbitmq/*
	cd $(DEVSTACK_DIR) && ./stack.sh

unstack:
	cd $(DEVSTACK_DIR) && ./unstack.sh

screen:
	screen -r

openrc:
	pushd $(DEVSTACK_DIR) ; source ./openrc ; popd
