TARGET=Celestine
CC=gcc

SRC_PATH=src
OBJ_PATH=obj
BIN_PATH=bin

SRC=$(foreach x, $(SRC_PATH), $(wildcard $(addprefix $(x)/*,.c*)))
OBJS=$(addprefix $(OBJ_PATH)/, $(addsuffix .o, $(notdir $(basename $(SRC)))))

INCLUDES=-Ilib/glad/include -Ilib/glfw/include -Llib/glfw/build/src
CFLAGS=-O3 -Wall -Wextra -g $(INCLUDES)
LDFLAGS=-lm -lglfw3

all: $(BIN_PATH)/$(TARGET)

$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c
	@mkdir -p $(OBJ_PATH)
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN_PATH)/$(TARGET): $(OBJS)
	@echo : LINK-EXECUTABLE
	@mkdir -p $(BIN_PATH)
	$(CC) $(CFLAGS) -o $(BIN_PATH)/$(TARGET) $^ $(LDFLAGS)

help:
	@echo make       - Compiles the target executable
	@echo make run   - Runs the compiled executable
	@echo make help  - Shows this help message again
	@echo make clean - Cleans object and executable files

run: 
	@echo : RUN-TARGET
	$(BIN_PATH)/$(TARGET)

clean:
	@echo : CLEAN-STAGING
	-@rm -rf $(OBJ_PATH)/*.o
	-@rm -rf $(BIN_PATH)/*
	-@rmdir $(BIN_PATH) $(OBJ_PATH)

