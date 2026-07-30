LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),kansas)

$(shell cp -a $(LOCAL_PATH)/. $(TARGET_RECOVERY_ROOT_OUT)/)

include $(call all-subdir-makefiles,$(LOCAL_PATH))

endif