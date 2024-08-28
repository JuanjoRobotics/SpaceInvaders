blank :=
define newline


$(blank)
endef

# Compiler
CC := g++

# Directories
SRC_DIR := src
INCLUDE_DIR := include
LIB_DIR := lib
BIN_DIR := bin

# Flags
COMPILER_FLAGS := -I$(INCLUDE_DIR)
LINKER_FLAGS := -lmingw32 -lSDL2main -lSDL2 -lSDL2_image

# Executable name
OBJ_NAME := program

# Get C++ sources and objects
SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(patsubst $(SRC_DIR)/%.cpp,$(BIN_DIR)/%.o,$(SRCS))
BINS := $(subst $(BIN_DIR)/,, $(wildcard $(BIN_DIR)/*.dll))

.PHONY: all clean

all: $(OBJ_NAME)

$(BIN_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BIN_DIR)
	$(CC) -c -o $@ $< $(COMPILER_FLAGS)

$(OBJ_NAME): $(OBJS)
	$(CC) -I $(INCLUDE_DIR) -L $(LIB_DIR) -o $@ $^ $(LINKER_FLAGS)
	$(foreach bin, $(BINS), $(newline)copy $(BIN_DIR)\$(bin))

$(BIN_DIR):
	mkdir $(BIN_DIR)

clean:
	del /q *.exe
	del /q $(BIN_DIR)\*.dll
	del /q $(BIN_DIR)\*.o
	rmdir /s /q $(BIN_DIR)