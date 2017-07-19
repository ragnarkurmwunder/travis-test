BIN = bin/binary
SRC = source.c
SRC = "$(TRAVIS_BUILD_DIR)/bin"
STAMP = "$(shell date +'%Y%m%d-%H%M%S')"
DST = "ragnar@delfiin.waalaskala.com:/home/ragnar/travis-test/$(STAMP)"


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
		$(SRC) \
		$(DST)
