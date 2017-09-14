DEV_ROCKS = busted luacheck
BUSTED_ARGS ?= -v
TEST_CMD ?= busted $(BUSTED_ARGS)

.PHONY: install dev lint test

install:
	@luarocks make kong-plugin-argonath-kenny-loggins-*.rockspec

dev: install
	@for rock in $(DEV_ROCKS) ; do \
		if ! luarocks list | grep $$rock > /dev/null ; then \
      echo $$rock not found, installing via luarocks... ; \
      luarocks install $$rock ; \
		else \
      echo $$rock already installed, skipping ; \
    fi \
	done;

lint:
	@luacheck -q . \
						--std 'ngx_lua+busted' \
						--globals '_KONG' \
						--globals 'ngx' \
						--globals 'assert' \
						--no-redefined \
						--no-unused-args \
						--ignore 6..

test:
	@$(TEST_CMD) test
