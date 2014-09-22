$(eval ALL_MODULES += $(MODULE))
.PHONY: $(MODULE)

LOCAL_C_SOURCES := $(filter %.c,$(LOCAL_SRCS))
LOCAL_CPP_SOURCES := $(filter %.cpp,$(LOCAL_SRCS))

cflags := $(LOCAL_CFLAGS) $(CFLAGS) -MMD -fPIC
$(foreach file,$(LOCAL_C_SOURCES),$(eval $(call c_template,$(file))))

cflags := $(LOCAL_CXXFLAGS) -MMD -fPIC
$(foreach file,$(LOCAL_CPP_SOURCES),$(eval $(call cpp_template,$(file))))

LOCAL_LIB := $(BUILDDIR)/$(MODULE)/lib$(MODULE).so

define shared_lib_template
$(LOCAL_LIB): $(intermediateDirObj) $(LOCAL_OBJS)
	$$(LD) -shared -soname lib$(MODULE).so -o $(LOCAL_LIB) $(LOCAL_OBJS)
endef

$(eval $(call shared_lib_template))

$(MODULE): $(LOCAL_LIB)
