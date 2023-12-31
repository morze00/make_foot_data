CXX=clang++
LINKER=clang++

ROOTCONFIG := root-config

CFLAGS := $(shell $(ROOTCONFIG) --cflags)
CFLAGS += -I${FAIRROOTPATH}/include
CFLAGS += -I$(SIMPATH)/include
CFLAGS += -I$(SIMPATH)/include
CFLAGS += -I$(ROOT_INCLUDE_PATH)
CFLAGS += -I$(ROOT_INCLUDE_DIR)
CFLAGS += --std=c++17 -g -O0 -fexceptions
#CFLAGS += -g -Wall -W -Wconversion -Wshadow -Wcast-qual -Wwrite-strings 

LDFLAGS := $(shell $(ROOTCONFIG) --ldflags)
LDFLAGS += -lEG $(shell $(ROOTCONFIG) --glibs)
LDFLAGS += -L$(ROOT_LIBRARY_DIR) -L$(FAIRROOTPATH)/lib
LDFLAGS += -g

INCLUDEDIR=include
DIR_INC=-I$(INCLUDEDIR)
EXEC=make_foot_data
OBJ=make_foot_data.o

HEADERS= libs.hh

DEPS = $(patsubst %,$(INCLUDEDIR)/%,$(HEADERS))

%.o : %.cpp $(DEPS)
	$(MAKEDEPEND)
	${CXX} ${CFLAGS} $(DIR_INC) -c $< -o $@
	echo "	CXX $@"


default: $(OBJ)
	${LINKER} ${LDFLAGS} ${CFLAGS} -o $(EXEC) $(DIR_INC) $(OBJ)
	echo " COMP $(EXEC)"


clean:
	rm -f *.o
	rm -f make_foot_data
	rm -rf *.dSYM
