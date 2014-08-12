ALL_MODULES += $(MODULE)
.PHONY: $(MODULE)

INTER_DIR := $(TOP)/build/$(MODULE)/objs
.PHONY: $(INTER_DIR)

$(INTER_DIR):
	$(SILENT) mkdir -p $(INTER_DIR)

LOCAL_C_SOURCES += $(filter %.c,$(LOCAL_SRCS))
LOCAL_OBJS += $(addprefix $(INTER_DIR)/, $(patsubst %.c,%.o,$(LOCAL_C_SOURCES)))

LOCAL_CPP_SOURCES += $(filter %.cpp,$(LOCAL_SRCS))
LOCAL_OBJS += $(addprefix $(INTER_DIR)/, $(patsubst %.cpp,%.o,$(LOCAL_CPP_SOURCES)))


define c_to_o
$(1)_obj_file = $(addprefix $(INTER_DIR)/, $(patsubst %.c,%.o,$(1)))
$(1)_src_file = $(abspath $(1))
$($(1)_obj_file): $(INTER_DIR) $($(1)_src_file)
	$$(CC) -c $($(1)_src_file) -o $($(1)_obj_file)
endef

define build_module
$(MODULE): $(LOCAL_OBJS)
	@echo "Building $(MODULE) $(LOCAL_OBJS)"
endef

$(foreach file,$(LOCAL_C_SOURCES),$(eval $(call c_to_o,$(file))))

$(eval $(call build_module))

