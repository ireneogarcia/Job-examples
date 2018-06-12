
# Echo styles
#---------1 = negrita, 31 = rojo-------------
RED='\033[1;31m'
BLUE='\033[1;34m'
NOCOLOR= '\033[0m'


# Needed directories.
SRCDIR := src
OBJDIR := obj
INCDIR := include 
BINDIR := bin

# Resources.
SOURCES := $(wildcard $(SRCDIR)/*.c)
OBJECTS := $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
INCLUDES := $(foreach inc, $(INCDIR), -I$(inc)) 
LIBS := -lmodbus

# Compilation.
TARGET=modbus_virtual_server
CC := gcc
CFLAGS := -Wall $(INCLUDES)

# all is defined before TARGET so it is going to run the code, if it was after TARGET, it wouldn't run.
all: mkdirs $(TARGET)

# TARGET depend of OBJECTS,so OBJECTS will be runned before TARGET.
$(TARGET): $(OBJECTS)
	@echo -e $(BLUE) 'creating executable...' $(NOCOLOR)
	$(CC) $(OBJECTS) $(CFLAGS) $(LIBS) -o $(BINDIR)/$(TARGET)


mkdirs: 
	@echo -e $(BLUE) 'creating directories...' $(NOCOLOR)
	mkdir -p bin
	mkdir -p obj


# Compilation of sources.
$(OBJECTS): $(OBJDIR)/%.o: $(SRCDIR)/%.c 
	@echo -e $(BLUE) 'creating objects...' $(NOCOLOR)
	$(CC) $< $(CFLAGS) -c -o $@

# .PHONY avoid a make confusion when one file is named equal this target.
.PHONY: clean
clean:
	@echo -e $(RED) 'cleaning...' $(NOCOLOR)
	rm -rf $(OBJDIR)

# This code clean 
.PHONY: remove
remove:
	rm -rf $(OBJDIR)
	rm -rf $(BINDIR)
