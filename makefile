##############################################################################
# x86 cross compiler                                                         #
##############################################################################
X86_CC := /usr/bin/gcc
X86_LD := /usr/bin/ld
vpath %.c = .
APPS := race.c


##############################################################################
# cross compiler options                                                     #
##############################################################################
WARNINGS 		:= -Wall -Wno-unused -Wno-format-y2k -Wno-deprecated-declarations
X86_CFLAGS  	:= -O2 $(WARNINGS)
X86_LDFLAGS 	:=


###########################################################
# generic rules                                           #
###########################################################
%.o: %.c
	@echo "------- (x86-O) compiling $X/$@"
	@$(X86_CC) $(X86_CFLAGS) -c $< -o $@

%: %.c
	@echo "------- (x86-E) compiling $X/$@"
	@$(X86_CC) $(X86_CFLAGS) $^ -o $@

%: %.o
	@echo "------- (x86-L) linking $X/$@"
	@$(X86_CC) $(X86_CFLAGS) $^ -o $@


##############################################################################
# define sources                                                             #
##############################################################################
BINOUTS	:= $(subst .c,,$(APPS))
OBJECTS := $(subst .c,.o,$(APPS))


##############################################################################
# compile                                                                    #
##############################################################################
.PHONY: all
all: $(OBJECTS) $(BINOUTS)


.PHONY: clean
clean:
	@echo "cleaning applications"
	@/bin/rm -f *.{o,exe}

