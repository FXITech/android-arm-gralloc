# 
# Copyright (C) 2010 ARM Limited. All rights reserved.
# 
# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifeq ($(TARGET_BOARD_PLATFORM),cottoncandy)
LOCAL_PATH := $(call my-dir)

# HAL module implemenation, not prelinked and stored in
# hw/<OVERLAY_HARDWARE_MODULE_ID>.<ro.product.board>.so
include $(CLEAR_VARS)
LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

# libMali will be installed post build
#LOCAL_SHARED_LIBRARIES := liblog libcutils libMali libGLESv1_CM libUMP
LOCAL_SHARED_LIBRARIES := liblog libcutils libGLESv1_CM libUMP
LOCAL_CFLAGS := -fpermissive

LOCAL_C_INCLUDES := system/core/include/ $(MALI_DDK_PATH)/include 
# Include the UMP header files
LOCAL_C_INCLUDES := hardware/fxi/cottoncandy/ump/include

LOCAL_SRC_FILES := \
	gralloc_module.cpp \
	alloc_device.cpp \
	framebuffer_device.cpp

LOCAL_MODULE := gralloc.cottoncandy
LOCAL_MODULE_TAGS := eng
LOCAL_CFLAGS:= -DLOG_TAG=\"gralloc_ump\" -DGRALLOC_32_BITS -DSTANDARD_LINUX_SCREEN -fpermissive
ifeq ($(BOARD_HAVE_CODEC_SUPPORT),SAMSUNG_CODEC_SUPPORT)
LOCAL_CFLAGS     += -DSAMSUNG_CODEC_SUPPORT
LOCAL_C_INCLUDES += frameworks/base/media/libstagefright/include
endif
#LOCAL_CFLAGS+= -DMALI_VSYNC_EVENT_REPORT_ENABLE
include $(BUILD_SHARED_LIBRARY)
endif
