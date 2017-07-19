BIN = binary
SRC = source.c

$(BIN): $(SRC)
	gcc -Wall -o $@ $^

test:
	./$(BIN)

clean:
	-rm -f $(BIN)
