BIN = bin/binary
SRC = source.c
STAMP = $(shell date +'%Y%m%d-%H%M%S')
DEPLOY_USERHOST = ragnar@delfiin.waalaskala.com
DEPLOY_BASE = /home/ragnar/travis-test
DEPLOY_SRC = "$(TRAVIS_BUILD_DIR)/bin"
DEPLOY_DST = "$(DEPLOY_USERHOST):$(DEPLOY_BASE)/$(STAMP)"
DEPLOY_SCRIPT_NAME = post-deploy
DEPLOY_SCRIPT_SRC = "$(TRAVIS_BUILD_DIR)/$(DEPLOY_SCRIPT_NAME)"
DEPLOY_SCRIPT_PATH_DST = $(DEPLOY_BASE)/$(DEPLOY_SCRIPT_NAME)
DEPLOY_SCRIPT_DST = "$(DEPLOY_USERHOST):$(DEPLOY_SCRIPT_PATH_DST)"


$(BIN): $(SRC)
	gcc -Wall -o $@ $^

test:
	./$(BIN)

clean:
	-rm -f $(BIN)

deploy:
	rsync \
		-r \
		--quiet \
		$(DEPLOY_SRC) \
		$(DEPLOY_DST)
	rsync \
		--quiet \
		$(DEPLOY_SCRIPT_SRC) \
		$(DEPLOY_SCRIPT_DST)
	ssh \
		"$(DEPLOY_USERHOST)" \
		"$(DEPLOY_SCRIPT_PATH_DST)" \
		"$(STAMP)"
