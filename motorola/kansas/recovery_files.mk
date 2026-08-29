LOCAL_PATH := device/motorola/kansas/recovery/root

# ================================================================
# Recovery root init files and rc files
# ================================================================
PRODUCT_COPY_FILES += \
 #   device/motorola/kansas/recovery/root/android.hardware.health-service.example_recovery.rc:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/init/android.hardware.health-service.example_recovery.rc \
    device/motorola/kansas/recovery/root/servicemanager.recovery.rc:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/init/servicemanager.recovery.rc \
    device/motorola/kansas/recovery/root/init.recovery.mt6835.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.recovery.mt6835.rc \
    device/motorola/kansas/recovery/root/mtk-plpath-utils.rc:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/init/mtk-plpath-utils.rc \
    device/motorola/kansas/recovery/root/snapuserd.rc:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/init/snapuserd.rc

# Optional – only enable if you really need them
# device/motorola/kansas/recovery/root/default.prop:$(TARGET_COPY_OUT_RECOVERY)/root/default.prop \
 device/motorola/kansas/recovery/root/prop.default:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/prop.default \

# device/motorola/kansas/recovery/root/plat_file_contexts:$(TARGET_COPY_OUT_RECOVERY)/root/plat_file_contexts \
# device/motorola/kansas/recovery/root/plat_property_contexts:$(TARGET_COPY_OUT_RECOVERY)/root/plat_property_contexts \
# device/motorola/kansas/recovery/root/vendor_file_contexts:$(TARGET_COPY_OUT_RECOVERY)/root/vendor_file_contexts \
# device/motorola/kansas/recovery/root/vendor_property_contexts:$(TARGET_COPY_OUT_RECOVERY)/root/vendor_property_contexts


#=====================
# First stage ramdisk
#====================

#=====================
# First stage ramdisk
#=====================

#PRODUCT_COPY_FILES += \
#    device/motorola/kansas/recovery/root/first_stage_ramdisk/fstab.emmc:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.emmc \
#    device/motorola/kansas/recovery/root/first_stage_ramdisk/fstab.mt6835:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.mt6835


#PRODUCT_COPY_FILES += \
#    $(call find-copy-subdir-files,*,device/motorola/kansas/recovery/root/first_stage_ramdisk,$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk)

# =======================
# TWRP recovery.fstab
# =======================
#PRODUCT_COPY_FILES += \
#    device/motorola/kansas/recovery/root/system/etc/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/recovery.fstab
#PRODUCT_COPY_FILES += \
#    device/motorola/kansas/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/recovery.fstab
# PRODUCT_COPY_FILES += \
#    device/motorola/kansas/twrp.flags:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/twrp.flags

# =========================
# Recovery vendor init (only the ones that are safe)
# =========================
#PRODUCT_COPY_FILES += \
#    device/motorola/kansas/recovery/root/vendor/etc/init/android.hardware.boot@1.2-service.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/android.hardware.boot@1.2-service.rc

# Comment these out for now – they are stock and often cause conflicts
#    device/motorola/kansas/recovery/root/vendor/etc/init/bootperf.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/bootperf.rc \
#    device/motorola/kansas/recovery/root/vendor/etc/init/hw/init.mmi.overlay.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/hw/init.mmi.overlay.rc \
#    device/motorola/kansas/recovery/root/vendor/etc/init/hw/init.mmi.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/hw/init.mmi.rc \
#    device/motorola/kansas/recovery/root/vendor/etc/init/hw/init.mmi.usb.configfs.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/hw/init.mmi.usb.configfs.rc \
#    device/motorola/kansas/recovery/root/vendor/etc/init/hw/init.mt6835.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/hw/init.mt6835.rc \
#    device/motorola/kansas/recovery/root/vendor/etc/init/hw/init.mt6835.usb.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/hw/init.mt6835.usb.rc \
#    device/motorola/kansas/recovery/root/vendor/etc/init/hw/init.mtkgki.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/hw/init.mtkgki.rc \
#    device/motorola/kansas/recovery/root/vendor/etc/init/hw/init.project.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/hw/init.project.rc

# ================================================================
# Product Motorola props – KEEP COMMENTED (pollutes recovery)
# ================================================================
#PRODUCT_COPY_FILES += \
#    device/motorola/kansas/recovery/root/product/etc/motorola/props/carrier.spectrum.kansas.prop:$(TARGET_COPY_OUT_PRODUCT)/etc/motorola/props/carrier.spectrum.kansas.prop \
#    device/motorola/kansas/recovery/root/product/etc/motorola/props/carrier.tmo.prop:$(TARGET_COPY_OUT_PRODUCT)/etc/motorola/props/carrier.tmo.prop \
#    device/motorola/kansas/recovery/root/product/etc/motorola/props/carrier.vzwpre.prop:$(TARGET_COPY_OUT_PRODUCT)/etc/motorola/props/carrier.vzwpre.prop \
#    device/motorola/kansas/recovery/root/product/etc/motorola/props/carrier.vzw.prop:$(TARGET_COPY_OUT_PRODUCT)/etc/motorola/props/carrier.vzw.prop \
#    device/motorola/kansas/recovery/root/product/etc/motorola/props/hardware.sku.XT2513-1.prop:$(TARGET_COPY_OUT_PRODUCT)/etc/motorola/props/hardware.sku.XT2513-1.prop \
#    device/motorola/kansas/recovery/root/product/etc/motorola/props/hardware.sku.XT2513-2.prop:$(TARGET_COPY_OUT_PRODUCT)/etc/motorola/props/hardware.sku.XT2513-2.prop \
#    device/motorola/kansas/recovery/root/product/etc/motorola/props/hardware.sku.XT2513-3.prop:$(TARGET_COPY_OUT_PRODUCT)/etc/motorola/props/hardware.sku.XT2513-3.prop \
#    device/motorola/kansas/recovery/root/product/etc/motorola/props/hardware.sku.XT2513V.prop:$(TARGET_COPY_OUT_PRODUCT)/etc/motorola/props/hardware.sku.XT2513V.prop

# ================================================================
# System props – only keep the light ones if needed
# ================================================================
#PRODUCT_COPY_FILES += \
#   device/motorola/kansas/recovery/root/system/ro.prop:$(TARGET_COPY_OUT_SYSTEM)/ro.prop \
#    device/motorola/kansas/recovery/root/system/rw.prop:$(TARGET_COPY_OUT_SYSTEM)/rw.prop

# ================================================================
# Vendor Motorola 12m – KEEP COMMENTED
# ================================================================
#PRODUCT_COPY_FILES += \
#    device/motorola/kansas/recovery/root/vendor/etc/motorola/12m/focaltech-boe_ft8057m-ft8057m-kansas.ini:$(TARGET_COPY_OUT_VENDOR)/etc/motorola/12m/focaltech-boe_ft8057m-ft8057m-kansas.ini \
#    device/motorola/kansas/recovery/root/vendor/etc/motorola/12m/focaltech-boe_ft8057m-primary-kansas.ini:$(TARGET_COPY_OUT_VENDOR)/etc/motorola/12m/focaltech-boe_ft8057m-primary-kansas.ini \
#    device/motorola/kansas/recovery/root/vendor/etc/motorola/12m/focaltech-boe_ft8057s-ft8057s-kansas.ini:$(TARGET_COPY_OUT_VENDOR)/etc/motorola/12m/focaltech-boe_ft8057s-ft8057s-kansas.ini \
#    device/motorola/kansas/recovery/root/vendor/etc/motorola/12m/focaltech-boe_ft8057s-primary-kansas.ini:$(TARGET_COPY_OUT_VENDOR)/etc/motorola/12m/focaltech-boe_ft8057s-primary-kansas.ini \
#    device/motorola/kansas/recovery/root/vendor/etc/motorola/12m/fac_test_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/motorola/12m/fac_test_config.xml \
#    device/motorola/kansas/recovery/root/vendor/etc/motorola/12m/key_code_map.txt:$(TARGET_COPY_OUT_VENDOR)/etc/motorola/12m/key_code_map.txt \
#    device/motorola/kansas/recovery/root/vendor/etc/motorola/12m/tcmd_leds.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/motorola/12m/tcmd_leds.cfg

######################################################
# Section vendor_ramdisk --> for use in vendor_ramdisk 
######################################################
#=====================
# First stage ramdisk
#=====================

PRODUCT_COPY_FILES += \
    device/motorola/kansas/vendor_ramdisk/vendor_ramdisk_dirplaceholder.txt:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor_ramdisk_dirplaceholder.txt
#    device/motorola/kansas/vendor_ramdisk/first_stage_ramdisk/fstab.mt6835:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.mt6835


# =======================
# TWRP recovery.fstab
# =======================
#PRODUCT_COPY_FILES += \
#    device/motorola/kansas/recovery.fstab:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/recovery.fstab
# PRODUCT_COPY_FILES += \
#    device/motorola/kansas/twrp.flags:$$(TARGET_VENDOR_RAMDISK_OUT)/system/etc/twrp.flags