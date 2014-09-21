
LOCAL_PATH := $(call my-dir)

include $(DEFINE_MODULE)
MODULE := cool
LOCAL_SRCS := cool.c
include $(BUILD_LIBRARY)

include $(DEFINE_MODULE)
MODULE := prog
LOCAL_SRCS := test.cpp
LOCAL_SHARED_LIBS := cool
include $(BUILD_EXE)

