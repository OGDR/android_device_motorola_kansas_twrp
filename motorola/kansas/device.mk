#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/motorola/kansas
$(call inherit-product, device/motorola/kansas/recovery_files.mk)
#$(call inherit-product, $(LOCAL_PATH)/fstab.mk)

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

#PRODUCT_SYSTEM_PROPERTIES += $(LOCAL_PATH)/system.prop
#PRODUCT_VENDOR_PROPERTIES += $(LOCAL_PATH)/vendor.prop
#PRODUCT_VENDOR_PROPERTIES += $(LOCAL_PATH)/vendor_dlkm.prop
#PRODUCT_ODM_PROPERTIES += $(LOCAL_PATH)/odm.prop
#PRODUCT_ODM_PROPERTIES += $(LOCAL_PATH)/odm_dlkm.prop
#PRODUCT_PRODUCT_PROPERTIES += $(LOCAL_PATH)/product.prop
