#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/motorola/kansas
$(call inherit-product, device/motorola/kansas/recovery_files.mk)
#$(call inherit-product, $(LOCAL_PATH)/fstab.mk)

# Dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service

PRODUCT_PACKAGES += \
    bootctrl.mt6835

#PRODUCT_STATIC_BOOT_CONTROL_HAL := \
#    bootctrl.mt6835 \

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload \
    task_profiles.json

# Task profiles required by libprocessgroup/logd in recovery
#PRODUCT_COPY_FILES += \
#    system/core/libprocessgroup/profiles/task_profiles.json:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/task_profiles.json


# Install init.recovery.service.rc
#PRODUCT_PACKAGES += \
#    init.recovery.service.rc

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd
#    android.hardware.fastboot@1.0-impl-mock

# For Shim to fix reference of symbol
PRODUCT_PACKAGES += \
    libbase_shim

# libion has to stay: nothing in TWRP relinks it, so this is the only thing
# putting it in the ramdisk.
TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    libbase_shim

# Actually include the shim in the recovery image --> libbase
TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libbase_shim.so

# system lib64/hw
#PRODUCT_COPY_FILES += \
#    $(DEVICE_PATH)/recovery/root/system/lib64/hw/android.hardware.boot@1.0-impl-1.2-mtkimpl.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/hw/android.hardware.boot@1.0-impl-1.2-mtkimpl.so \
#    $(DEVICE_PATH)/recovery/root/system/lib64/hw/android.hardware.fastboot@1.0-impl-mtk.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/hw/android.hardware.fastboot@1.0-impl-mtk.so \
#    $(DEVICE_PATH)/recovery/root/system/lib64/hw/android.hardware.health@2.0-impl-default.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/hw/android.hardware.health@2.0-impl-default.so

# vendor lib64/hw
#PRODUCT_COPY_FILES += \
#    $(DEVICE_PATH)/recovery/root/vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl.so \
#    $(DEVICE_PATH)/recovery/root/vendor/lib64/hw/gatekeeper.default.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/gatekeeper.default.so \
#    $(DEVICE_PATH)/recovery/root/vendor/lib64/hw/gatekeeper.trustonic.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/gatekeeper.trustonic.so \
#    $(DEVICE_PATH)/recovery/root/vendor/lib64/hw/libMcGatekeeper.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/libMcGatekeeper.so \
#    $(DEVICE_PATH)/recovery/root/vendor/lib64/hw/libSoftGatekeeper.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/libSoftGatekeeper.so

#PRODUCT_COPY_FILES += \
#    device/motorola/kansas/prebuilt/dtb:dtb.img

#RODUCT_COPY_FILES += \
#    $(PRODUCT_PREBUILT_DTB):dtb.img

#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/prebuilt/dtb:dtb.img

#PRODUCT_SYSTEM_PROPERTIES += $(LOCAL_PATH)/system.prop
#PRODUCT_VENDOR_PROPERTIES += $(LOCAL_PATH)/vendor.prop
#PRODUCT_VENDOR_PROPERTIES += $(LOCAL_PATH)/vendor_dlkm.prop
#PRODUCT_ODM_PROPERTIES += $(LOCAL_PATH)/odm.prop
#PRODUCT_ODM_PROPERTIES += $(LOCAL_PATH)/odm_dlkm.prop
#PRODUCT_PRODUCT_PROPERTIES += $(LOCAL_PATH)/product.prop
