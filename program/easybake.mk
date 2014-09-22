
LOCAL_PATH := $(call my-dir)


include $(DEFINE_MODULE)
MODULE := prog
LOCAL_SRCS := src/test.cpp
LOCAL_CXXFLAGS := -Wall
LOCAL_SHARED_LIBS := cool
include $(BUILD_EXE)

