BIN = bin/binary
SRC = source.c
STAMP = "$(shell date +'%Y%m%d-%H%M%S')"
DEPLOY_SRC = "$(TRAVIS_BUILD_DIR)/bin"
DEPLOY_DST = "ragnar@delfiin.waalaskala.com:/home/ragnar/travis-test/$(STAMP)"


$(BIN): $(SRC)
	gcc -Wall -o $@ $^

test:
	./$(BIN)

clean:
	-rm -f $(BIN)

deploy:
	rsync \
		-r \
		--delete-after \
		--quiet \
		$(DEPLOY_SRC) \
		$(DEPLOY_DST)
