
LOCAL_PATH := $(call my-dir)

include $(DEFINE_MODULE)
MODULE := cool
LOCAL_SRCS := src/cool.c
LOCAL_CFLAGS := -Wall
include $(BUILD_LIBRARY)


