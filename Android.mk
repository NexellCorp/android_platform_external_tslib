#########BOARD_USES_TSLIB############
ifeq ($(BOARD_USES_TSLIB),true)

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

local_target_dir := $(TARGET_OUT)/etc/tslib
LOCAL_MODULE := ts.conf
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := etc/$(LOCAL_MODULE)
include $(BUILD_PREBUILT)

#################################################################
include $(CLEAR_VARS)

C_INCLUDES += \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/src \
	$(LOCAL_PATH)/plugins

CFLAGS += -DTS_POINTERCAL=\"/system/etc/pointercal\" \
	  -DTSLIB_INTERNAL \
	  -DGCC_HASCLASSVISIBILITY

LOCAL_MODULE:= linear
LOCAL_PRELINK_MODULE := false
LOCAL_CFLAGS = $(CFLAGS)
LOCAL_C_INCLUDES = $(C_INCLUDES)
LOCAL_SRC_FILES = plugins/linear.c
LOCAL_SHARED_LIBRARIES += libts
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/ts
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE:= dejitter
LOCAL_PRELINK_MODULE := false
LOCAL_CFLAGS = $(CFLAGS)
LOCAL_C_INCLUDES = $(C_INCLUDES)
LOCAL_SRC_FILES =  plugins/dejitter.c
LOCAL_SHARED_LIBRARIES += libts
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/ts
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE:= variance
LOCAL_PRELINK_MODULE := false
LOCAL_CFLAGS = $(CFLAGS)
LOCAL_C_INCLUDES = $(C_INCLUDES)
LOCAL_SRC_FILES =  plugins/variance.c
LOCAL_SHARED_LIBRARIES += libts
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/ts
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE:= pthres
LOCAL_PRELINK_MODULE := false
LOCAL_CFLAGS = $(CFLAGS)
LOCAL_C_INCLUDES = $(C_INCLUDES)
LOCAL_SRC_FILES =  plugins/pthres.c
LOCAL_SHARED_LIBRARIES += libts
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/ts
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE:= input
LOCAL_PRELINK_MODULE := false
LOCAL_CFLAGS = $(CFLAGS)
LOCAL_C_INCLUDES = $(C_INCLUDES)
LOCAL_SRC_FILES =  plugins/input-raw.c
LOCAL_SHARED_LIBRARIES += libts
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/ts
include $(BUILD_SHARED_LIBRARY)

#################################################################
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	src/ts_attach.c \
	src/ts_close.c \
	src/ts_config.c \
	src/ts_error.c \
	src/ts_fd.c \
	src/ts_load_module.c \
	src/ts_open.c \
	src/ts_parse_vars.c \
	src/ts_read.c \
	src/ts_read_raw.c

LOCAL_CFLAGS += -DPLUGIN_DIR=\"/system/lib/ts\" \
		-DTS_CONF=\"/system/etc/tslib/ts.conf\" \
		-DTSLIB_INTERNAL
LOCAL_C_INCLUDES += \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/src

LOCAL_SHARED_LIBRARIES += libdl
LOCAL_PRELINK_MODULE := false

LOCAL_MODULE:= libts

include $(BUILD_SHARED_LIBRARY)

#################################################################
include $(CLEAR_VARS)

INCLUDES += \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/src \
	$(LOCAL_PATH)/tests

CFLAGS += -DTS_POINTERCAL=\"/system/etc/pointercal\" \
		-DGCC_HASCLASSVISIBILITY

SRC_FILES += tests/fbutils.c \
	     tests/font_8x8.c \
	     tests/font_8x16.c

SHARED_LIBRARIES = libts

LOCAL_MODULE := ts_test
LOCAL_SRC_FILES = tests/ts_test.c \
		  $(SRC_FILES)
LOCAL_C_INCLUDES = $(INCLUDES)
LOCAL_CFLAGS = $(CFLAGS)
LOCAL_SHARED_LIBRARIES = $(SHARED_LIBRARIES)
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := ts_calibrate
LOCAL_SRC_FILES = tests/ts_calibrate.c \
		  tests/testutils.c \
		  $(SRC_FILES)
LOCAL_C_INCLUDES = $(INCLUDES)
LOCAL_CFLAGS = $(CFLAGS)
LOCAL_SHARED_LIBRARIES = $(SHARED_LIBRARIES)
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := ts_print
LOCAL_SRC_FILES = tests/ts_print.c
LOCAL_C_INCLUDES = $(INCLUDES)
LOCAL_CFLAGS = $(CFLAGS)
LOCAL_SHARED_LIBRARIES = $(SHARED_LIBRARIES)
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := ts_print_raw
LOCAL_SRC_FILES = tests/ts_print_raw.c
LOCAL_C_INCLUDES = $(INCLUDES)
LOCAL_CFLAGS = $(CFLAGS)
LOCAL_SHARED_LIBRARIES = $(SHARED_LIBRARIES)
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := ts_harvest
LOCAL_SRC_FILES = tests/ts_harvest.c \
		  tests/testutils.c \
		  $(SRC_FILES)
LOCAL_C_INCLUDES = $(INCLUDES)
LOCAL_CFLAGS = $(CFLAGS)
LOCAL_SHARED_LIBRARIES = $(SHARED_LIBRARIES)
include $(BUILD_EXECUTABLE)


endif 
#########BOARD_USES_TSLIB############
