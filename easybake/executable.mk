$(eval ALL_MODULES += $(MODULE))


LOCAL_C_SOURCES += $(filter %.c,$(LOCAL_SRCS))
LOCAL_CPP_SOURCES += $(filter %.cpp,$(LOCAL_SRCS))

cflags := $(LOCAL_CFLAGS) $(CFLAGS) -MMD
$(foreach file,$(LOCAL_C_SOURCES),$(eval $(call c_template,$(file))))

cflags := $(LOCAL_CXXFLAGS) $(CXXFLAGS) -MMD
$(foreach file,$(LOCAL_CPP_SOURCES),$(eval $(call cpp_template,$(file))))

$(foreach lib,$(LOCAL_SHARED_LIBS),$(eval LOCAL_OBJS += $(BUILDDIR)/$(lib)/lib$(lib).so))


LOCAL_EXE := $(MODULE)

define exec_template
$(LOCAL_EXE): $(LOCAL_OBJS) $(LOCAL_SHARED_LIBS)
	g++ -o $(LOCAL_EXE) $(LOCAL_OBJS)
endef

$(eval $(call exec_template))
