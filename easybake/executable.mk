$(eval ALL_MODULES += $(MODULE))

$(eval intermediateDir := $(BUILDDIR)/$(MODULE))
$(eval intermediateDirObj := $(intermediateDir)/.marker)

$(eval $(call make-intermediate-dir))

LOCAL_C_SOURCES += $(filter %.c,$(LOCAL_SRCS))
LOCAL_OBJS += $(addprefix $(intermediateDir)/, $(patsubst %.c,%.o,$(LOCAL_C_SOURCES)))

LOCAL_CPP_SOURCES += $(filter %.cpp,$(LOCAL_SRCS))
LOCAL_OBJS += $(addprefix $(intermediateDir)/, $(patsubst %.cpp,%.o,$(LOCAL_CPP_SOURCES)))

$(foreach lib,$(LOCAL_SHARED_LIBS),$(eval LOCAL_OBJS += $(BUILDDIR)/$(lib)/lib$(lib).so))

cflags := $(LOCAL_CFLAGS) $(CFLAGS) -MMD

$(foreach file,$(LOCAL_C_SOURCES),$(eval $(call c_template,$(file))))
$(foreach file,$(LOCAL_CPP_SOURCES),$(eval $(call cpp_template,$(file))))

LOCAL_EXE := $(MODULE)

define exec_template
$(LOCAL_EXE): $(LOCAL_OBJS) $(LOCAL_SHARED_LIBS)
	$$(LD) -o $(LOCAL_EXE) $(LOCAL_OBJS)
endef

$(eval $(call exec_template))

