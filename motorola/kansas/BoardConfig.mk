#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/kansas

# Fix soong: include_se_omapi must be string, not bool
#$(call soong_config_set,twrpGlobalVars,include_se_omapi,false)

PRODUCT_SOONG_NAMESPACES += device/motorola/kansas/shims

BOARD_VNDK_VERSION := current

# Basic
ALLOW_MISSING_DEPENDENCIES := true

# Platform Version
PLATFORM_VERSION := 16.0

PRODUCT_FULL_TREBLE_OVERRIDE := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55
TARGET_IS_64_BIT := true

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

#  Platform and SoC
TARGET_SOC := mt6835
TARGET_BOARD_PLATFORM := mt6835

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := kansas
TARGET_NO_BOOTLOADER := true

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    system \
    system_ext \
    vbmeta_system \
    product \
    vendor \
    system_dlkm \
    vendor_dlkm \
    boot \
    vendor_boot

# vendor_boot recovery
BOARD_USES_RECOVERY_AS_BOOT := false
TARGET_NO_RECOVERY := true
#BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE :=
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true

# Display
TARGET_SCREEN_DENSITY := 280

# Kernel
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_OFFSET := 0x00000000
BOARD_DTB_OFFSET := 0x07c80000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 mem.enable_mglru=1 loglevel=4 initcall_debug=0
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x26f00000
BOARD_KERNEL_TAGS_OFFSET := 0x07c80000
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline "$(BOARD_KERNEL_CMDLINE)"
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_KERNEL_CONFIG := kansas_defconfig
TARGET_KERNEL_SOURCE := kernel/motorola/kansas

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb 
#TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt
endif

# Prebuilt images
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
BOARD_PREBUILT_VBMETAIMAGE := $(DEVICE_PATH)/prebuilt/vbmeta.img
BOARD_PREBUILT_VBMETA_SYSTEMIMAGE := $(DEVICE_PATH)/prebuilt/vbmeta_system.img

# Partitions (keep your sizes)
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_INIT_BOOTIMAGE_PARTITION_SIZE := 8388608
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := erofs
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
#BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SUPER_PARTITION_SIZE := 8355053568
BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product vendor_dlkm system_dlkm
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 8346664960
BOARD_VBMETAIMAGE_PARTITION_SIZE := 8388608
BOARD_VBMETA_SYSTEMIMAGE_PARTITION_SIZE := 8388608
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
TARGET_USERIMAGES_USE_EXT4 := true
#TARGET_USERIMAGES_USE_F2FS := true
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# AOSP ROM partition outputs:
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_SYSTEM := system
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

BOARD_AVB_ENABLE := true
BOARD_AVB_VBMETA_SYSTEM := system system_ext
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_ROLLBACK_INDEX := 19
BOARD_AVB_VBMETA_ROLLBACK_INDEX_LOCATION := 0
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 19
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

# Include all prebuilt modules
#BOARD_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)/recovery/root/lib/modules/*.ko)
#BOARD_KERNEL_MODULES += $(wildcard $(DEVICE_PATH)/recovery/root/vendor_dlkm/lib/modules/*.ko)
#BOARD_RECOVERY_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)/recovery/root/lib/modules/*.ko)
#BOARD_RECOVERY_KERNEL_MODULES += $(wildcard $(DEVICE_PATH)/recovery/root/vendor_dlkm/lib/modules/*.ko)
#BOARD_KERNEL_MODULES += $(wildcard $(DEVICE_PATH)/recovery/root/vendor/lib/modules/*.ko)
#BOARD_RECOVERY_KERNEL_MODULES += $(wildcard $(DEVICE_PATH)/recovery/root/vendor/lib/modules/*.ko)


# Metadata
BOARD_USES_METADATA_PARTITION := true
# boot and recovery use LZMA for more compression and saves more space
#LZMA_RAMDISK_TARGETS := boot,recovery
# Use legacy LZ4 for the ramdisk
BOARD_RAMDISK_USE_LZ4 := true

#PRODUCT_COPY_FILES += \
#    $(DEVICE_PATH)/prebuilt/modules.load:recovery/root/lib/modules/modules.load

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.0

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBA_8888  #RGBX_8888 and BGRA_8888 --> try for mtk6835 RGBX_8888
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy
TW_THEME := portrait_hdpi
#TW_EXTRA_LANGUAGES := false
#TW_EXCLUDE_PYTHON := true
#TW_DEFAULT_LANGUAGE := en
TW_NO_SCREEN_BLANK := true
TW_NO_SCREEN_TIMEOUT := true
TW_LOAD_VENDOR_MODULES := true
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true
TW_USE_TOOLBOX := true
TW_USE_FASTBOOTD := true
TW_INCLUDE_CRYPTO := false
TW_INCLUDE_CRYPTO_FBE := false
TW_INCLUDE_FBE_METADATA_DECRYPT := false
#TW_USE_FSCRYPT_POLICY := 2

# Additional properties
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# Screen (adjust if needed)
TARGET_SCREEN_WIDTH := 720
TARGET_SCREEN_HEIGHT := 1600
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 409
TW_CUSTOM_BATTERY_PATH := /sys/class/power_supply/battery/capacity

# Maintainer
TW_DEVICE_VERSION := OGDR

#TARGET_LD_SHIM_LIBS := \
#    /system/bin/hw/android.hardware.health-service.example_recovery|libbase_shim.so \
#    /system/lib64/hw/android.hardware.boot@1.0-impl-1.2-mtkimpl.so|libbase_shim.so 

#TARGET_LD_SHIM_LIBS := \
#    /system/bin/hw/android.hardware.health-service.example_recovery|/system/lib64/libbase_shim.so \
#    /system/lib64/hw/android.hardware.boot@1.0-impl-1.2-mtkimpl.so|/system/lib64/libbase_shim.so  

#TARGET_GLOBAL_CFLAGS += -Oz -ffunction-sections -fdata-sections -fno-unwind-tables -fno-asynchronous-unwind-tables -fomit-frame-pointer -fmerge-all-constants -flto
#TARGET_GLOBAL_CPPFLAGS += -Oz -ffunction-sections -fdata-sections -fno-unwind-tables -fno-asynchronous-unwind-tables -fomit-frame-pointer -fmerge-all-constants -flto
#TARGET_GLOBAL_LDFLAGS += -Wl,--gc-sections -Wl,--strip-all -Wl,--icf=all -flto -Wl,-Oz   