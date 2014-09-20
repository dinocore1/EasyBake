
CC := gcc
CPP := g++

EASYBAKEDIR := $(dir $(lastword $(MAKEFILE_LIST)))
TOP := $(abspath $(EASYBAKEDIR)/..)
BUILDDIR := $(TOP)/build


SILENT := @

DEFINE_MODULE := $(abspath $(EASYBAKEDIR)/module.mk)
BUILD_LIBRARY := $(abspath $(EASYBAKEDIR)/library.mk)

my-dir = $(dir $(lastword $(MAKEFILE_LIST)))



