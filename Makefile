CXX = g++ # Compiler
CXXFLAGS = -c -Ilibs\include -Isrc -DSFML_STATIC # Compile flags
LDFLAGS = -static -static-libgcc -static-libstdc++ -Llibs\lib # Linker flags
SFML_LDLIBS = -lsfml-window-s -lsfml-system-s\
 -lsfml-graphics-s -lopengl32 -lwinmm -lgdi32 -lfreetype -lopenal32 -lflac -lvorbisenc -lvorbisfile -lvorbis -logg -lws2_32 # SFML and dependices

SRC_DIR = src
SRC = $(wildcard $(SRC_DIR)/*.cpp)

BUILD_DIR = build
OBJ = $(SRC:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)
DEP = $(SRC:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.d)

all: app.exe

app.exe: $(OBJ)
	$(CXX) -o $@ $^ $(LDFLAGS) $(SFML_LDLIBS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) -MF $(patsubst %.o,%.d,$@) -MT $@  $< -MM 
	$(CXX) -o $@ $< $(CXXFLAGS)

.PHONY: clean
clean:
	del /q $(BUILD_DIR)\*.o $(BUILD_DIR)\*.d

-include $(DEP)
