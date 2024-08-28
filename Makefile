blank :=
define newline

$(blank)
endef

#Compiler
CC := g++

#Directories
SRC_DIR := src
INCLUDE_DIR := include
LIB_DIR := lib
BIN_DIR := bin

#Flags
COMPILER_FLAGS := -Iinclude
LINKER_FLAGS := -lmingw32 -lSDL2main -lSDL2 -lSDL2_image

#Executable name
OBJ_NAME := program

#Get c++ sources and objects
SRCS := $(wildcard $(SRC_DIR)/*.cpp)
BINS := ${subst $(BIN_DIR)/,, $(wildcard $(BIN_DIR)/*.dll)}
OBJS := $(patsubst $(SRC_DIR)/%.cpp, $(BIN_DIR)/%.o, $(SRCS))

all: $(OBJ_NAME)

$(BIN_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CC) -c -o $@ $< $(COMPILER_FLAGS)

$(OBJ_NAME): $(OBJS)
	$(LINK.cc) -I $(INCLUDE_DIR) -L $(LIB_DIR) -o $@ $^ $(LINKER_FLAGS)
	$(foreach bin, $(BINS), $(newline)copy $(BIN_DIR)\$(bin))

clean:
	del /q *.exe
	del /q *.dll
	del /q $(BIN_DIR)\*.o
