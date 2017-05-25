SYSTEM := $(shell sh -c 'uname -s 2>/dev/null')

shellcheck:
ifneq ($(shell shellcheck --version > /dev/null 2>&1 ; echo $$?),0)
ifeq ($(SYSTEM),Darwin)
	brew install shellcheck
else
	sudo add-apt-repository 'deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse'
	sudo apt-get update && sudo apt-get install -y shellcheck
endif
endif

ci-dependencies: shellcheck bats

bats:
ifneq ($(shell bats --version > /dev/null 2>&1 ; echo $$?),0)
ifeq ($(SYSTEM),Darwin)
	brew install bats
else
	git clone https://github.com/sstephenson/bats.git /tmp/bats
	cd /tmp/bats && sudo ./install.sh /usr/local
	rm -rf /tmp/bats
endif
endif

lint:
	@echo linting...
	@$(QUIET) find . -not -path '*/\.*' -type f | xargs file | grep text | awk -F ':' '{ print $$1 }' | xargs head -n1 | egrep -B1 "bash" | grep "==>" | awk '{ print $$2 }' | xargs shellcheck -e SC2034 -e SC1090

test: lint
