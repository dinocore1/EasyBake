ALL_MODULES += $(MODULE)
.PHONY: $(MODULE)

INTER_DIR := $(BUILDDIR)/$(MODULE)/objs
.PHONY: $(INTER_DIR)

$(INTER_DIR):
	$(SILENT) mkdir -p $(INTER_DIR)

get_o = $(addprefix $(INTER_DIR)/, $(pathsubst %.c,%.o,$(1)))

LOCAL_C_SOURCES += $(filter %.c,$(LOCAL_SRCS))
LOCAL_OBJS += $(addprefix $(INTER_DIR)/, $(patsubst %.c,%.o,$(LOCAL_C_SOURCES)))

LOCAL_CPP_SOURCES += $(filter %.cpp,$(LOCAL_SRCS))
LOCAL_OBJS += $(addprefix $(INTER_DIR)/, $(patsubst %.cpp,%.o,$(LOCAL_CPP_SOURCES)))

define c_to_d
$(INTER_DIR)/$(1:.c=.d): $(LOCAL_PATH)/$(1) $(INTER_DIR)
	$$(CC) -MM -o $(INTER_DIR)/$(1:.c=.d) $(1)
endef

define cpp_to_d
$(INTER_DIR)/$(1:.cpp=.d): $(LOCAL_PATH)/$(1) $(INTER_DIR)
	$$(CPP) -MM $(1) > $(INTER_DIR)/$(1:.cpp=.d)
endef

define c_to_o
$(INTER_DIR)/$(1:.c=.o): $(INTER_DIR)/$(1:.c=.d) $(INTER_DIR)
	$$(CC) -c -o $(INTER_DIR)/$(1:.c=.o) $$(CFLAGS) $(1)
endef

define cpp_to_o
$(INTER_DIR)/$(1:.cpp=.o): $(INTER_DIR)/$(1:.cpp=.d) $(INTER_DIR)
	$$(CPP) -c -o $(INTER_DIR)/$(1:.cpp=.o) $$(CFLAGS) $(1)
endef

$(foreach file,$(LOCAL_C_SOURCES),\
$(eval $(call c_to_d,$(file))) \
)

$(foreach file,$(LOCAL_C_SOURCES),\
$(eval $(call c_to_o,$(file))) \
)

$(foreach file,$(LOCAL_CPP_SOURCES),\
$(eval $(call cpp_to_d,$(file))) \
)

$(foreach file,$(LOCAL_CPP_SOURCES),\
$(eval $(call cpp_to_o,$(file))) \
)

LOCAL_LIB := $(addprefix $(INTER_DIR)/, lib$(MODULE).so)

$(LOCAL_LIB): $(LOCAL_OBJS)
	$(LD) link $@ %^ 

$(MODULE): $(LOCAL_LIB)
