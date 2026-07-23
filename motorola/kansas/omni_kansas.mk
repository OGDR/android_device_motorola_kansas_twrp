#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from kansas device
$(call inherit-product, device/motorola/kansas/device.mk)

PRODUCT_DEVICE := kansas
PRODUCT_NAME := omni_kansas
PRODUCT_BRAND := motorola
PRODUCT_MODEL := kansas
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="kansas_g_vext-user 13 W1VKS36H.9-12-11 12209 release-keys"

BUILD_FINGERPRINT := motorola/kansas_g_vext/kansas:13/W1VKS36H.9-12-11/12209:user/release-keys
