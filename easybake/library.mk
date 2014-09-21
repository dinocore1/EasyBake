ALL_MODULES += $(MODULE)
.PHONY: $(MODULE)

intermediateDir := $(BUILDDIR)/$(MODULE)
intermediateDirObj := $(intermediateDir)/.marker

$(intermediateDirObj):
	$(SILENT) mkdir -p $(intermediateDir)
	$(SILENT) touch $(intermediateDirObj)


LOCAL_C_SOURCES += $(filter %.c,$(LOCAL_SRCS))
LOCAL_OBJS += $(addprefix $(intermediateDir)/, $(patsubst %.c,%.o,$(LOCAL_C_SOURCES)))

LOCAL_CPP_SOURCES += $(filter %.cpp,$(LOCAL_SRCS))
LOCAL_OBJS += $(addprefix $(intermediateDir)/, $(patsubst %.cpp,%.o,$(LOCAL_CPP_SOURCES)))


cflags := $(LOCAL_CFLAGS) $(CFLAGS) -MMD -fPIC

$(foreach file,$(LOCAL_C_SOURCES),$(eval $(call c_template,$(file))))
$(foreach file,$(LOCAL_CPP_SOURCES),$(eval $(call cpp_template,$(file))))

LOCAL_LIB := $(BUILDDIR)/$(MODULE)/lib$(MODULE).so

define shared_lib_template
$(LOCAL_LIB): $(intermediateDirObj) $(LOCAL_OBJS)
	$$(LD) -shared -o $(LOCAL_LIB) $(LOCAL_OBJS)
endef

$(eval $(call shared_lib_template))

$(MODULE): $(LOCAL_LIB)
