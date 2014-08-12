
LOCAL_PATH := $(call my-dir)

include $(DEFINE_MODULE)
MODULE := test
LOCAL_SRCS := cool.c test.c 

include $(BUILD_LIBRARY)

