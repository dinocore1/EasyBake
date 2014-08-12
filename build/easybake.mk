
BUILDDIR := $(dir $(lastword $(MAKEFILE_LIST)))
TOP := $(abspath $(BUILDDIR)/..)

MODULE = $(abspath $(BUILDDIR)/module.mk)
