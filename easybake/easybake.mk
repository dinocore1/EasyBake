
BUILDDIR := $(dir $(lastword $(MAKEFILE_LIST)))
TOP := $(abspath $(BUILDDIR)/..)

SILENT := @

DEFINE_MODULE := $(abspath $(BUILDDIR)/module.mk)
BUILD_LIBRARY := $(abspath $(BUILDDIR)/library.mk)

my-dir = $(dir $(lastword $(MAKEFILE_LIST)))

.PHONY: all clean

all: $(ALL_MODULES)

clean:
	rm -rf build/
