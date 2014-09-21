
CC := gcc
CXX := g++
LD := g++

EASYBAKEDIR := $(dir $(lastword $(MAKEFILE_LIST)))
TOP := $(abspath $(EASYBAKEDIR)..)
BUILDDIR := build


SILENT := @

DEFINE_MODULE := $(abspath $(EASYBAKEDIR)/module.mk)
BUILD_LIBRARY := $(abspath $(EASYBAKEDIR)/library.mk)
BUILD_EXE := $(abspath $(EASYBAKEDIR)/executable.mk)
COMPILE := $(abspath $(EASYBAKEDIR)/compile.mk)

my-dir = $(dir $(lastword $(MAKEFILE_LIST)))

define all-makefiles-under
$(wildcard $(1)/*/easybake.mk)
endef

define make-intermediate-dir
$(intermediateDirObj):
	$(SILENT) mkdir -p $(intermediateDir)
	$(SILENT) touch $(intermediateDirObj)
endef


############ C/C++ definitions ################

define compile
$(OBJ): $(intermediateDirObj) $(SRC)
	$(COMPILER) -c -o $(OBJ) $(cflags) $(SRC)

-include $(DEPEND)

endef

define c_template
$(eval COMPILER := $(CC))
$(eval SRC := $(1))
$(eval OBJ := $(intermediateDir)/$(1:.c=.o))
$(eval DEPEND := $(intermediateDir)/$(1:.c=.d))

$(eval $(call compile))
endef

define cpp_template
$(eval COMPILER := $(CXX))
$(eval SRC := $(1))
$(eval OBJ := $(intermediateDir)/$(1:.cpp=.o))
$(eval DEPEND := $(intermediateDir)/$(1:.cpp=.d))

$(eval $(call compile))
endef

################################################

.PHONY: all clean

all: $(ALL_MODULES)

clean:
	rm -rf $(BUILDDIR)

include $(wildcard $(TOP)/easybake.mk)


