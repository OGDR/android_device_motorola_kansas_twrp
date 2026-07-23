android_device_motorola_kansas_twrp

TWRP device tree for:

Motorola Moto G 5G 2025
Kansas XT2513-1
MediaTek MT6835
Android 16

=================================================
KANSAS TWRP STATUS
=================================================

Bootloader Unlock
    Status: WORKING

Root Access
    Status: WORKING

Stock boot.img Extracted
    Status: WORKING

Stock vendor_boot.img Extracted
    Status: WORKING

Stock dtbo.img Extracted
    Status: WORKING

DTBO Overlay Analysis
    Status: WORKING

Touchscreen Hardware Identified
    Status: WORKING

Display Panel Hardware Identified
    Status: WORKING

TWRP Boot
    Status: WORKING

TWRP Touchscreen
    Status: NOT WORKING

TWRP ADB
    Status: NOT WORKING

TWRP Mouse Support
    Status: NOT TESTED

TWRP Log Collection
    Status: NOT TESTED

TWRP Device Tree
    Status: IN PROGRESS

TWRP Build Environment
    Status: NOT STARTED

First Source-Built TWRP
    Status: NOT STARTED

Kansas ROM Environment
    Status: NOT STARTED

=================================================
HARDWARE FINDINGS
=================================================

Touchscreen:

NVTCapacitiveTouchScreen

DTBO:

compatible = "novatek,NVT-ts-spi";

Kernel Module:

nova_0flash_mmi_v3.ko

=================================================
DISPLAY PANEL FINDINGS
=================================================

Novatek Panels:

NT36528A
NT36528

Related Modules:

dsi-panel-mot-tm-nt36528a-667-hdp-dphy-vdo-120hz.ko
dsi-panel-mot-tm-nt36528-667-hdp-dphy-vdo-120hz.ko
nova_0flash_mmi_v3.ko

FocalTech Panels:

FT8057S
FT8057M

Related Modules:

dsi-panel-mot-boe-ft8057s-667-hdp-dphy-vdo-120hz.ko
dsi-panel-mot-boe-ft8057m-667-hdp-dphy-vdo-120hz.ko
focaltech_0flash_mmi_v3.ko

Observed DTBO Relationships:

Novatek Touch
↓
NT36528 Panels

FocalTech Touch
↓
FT8057 Panels

=================================================
DTBO FINDINGS
=================================================

Android DTBO Magic:

d7 b7 ab 1e

Embedded DTB Magic:

d0 0d fe ed

Observed Nodes:

novatek@0
focaltech@1
fragment@0
__overlay__
pmic@4
mediatek,mt6377

Battery Mapping Strings:

COSRA50COS
ATLRA50NVT

Observed:

ATLRA50NVT likely indicates a Novatek hardware variant.

=================================================
KNOWN GOOD FILES
=================================================

boot.img
vendor_boot.img
dtbo.img

=================================================
CURRENT RECOVERY INVESTIGATION
=================================================

Touchscreen initialization

Vendor_boot ramdisk

Module loading

DTBO overlays

Display compatibility

Recovery startup

=================================================
PROJECT GOALS
=================================================

Working TWRP
↓
Touchscreen Support
↓
Recovery Testing
↓
TWRP Device Tree Completion
↓
TWRP Source Build
↓
Kansas ROM Development

=================================================
REPOSITORY PURPOSE
=================================================

This repository contains:

- TWRP Device Tree
- Recovery Bring-up
- Recovery Debugging
- DTBO Investigation
- Touchscreen Investigation
- Display Investigation

ROM development will be maintained separately.

=================================================
EXTRACTION NOTES
=================================================

Stock Images Extracted:

boot.img
vendor_boot.img
dtbo.img

Tools Used:

twrpdtgen
dtc
dd
adb
fastboot
strings
grep

TWRPDTGEN Command:

python3 -m twrpdtgen "/home/eric/Projects/kansas generic boot vendor/vendor_boot.img"

=================================================
OGDR
=================================================

Keep it OG.

Let me use my phone.

I don't want to go blind.

Built by OGDR.


<img width="2560" height="2560" alt="moto5g" src="https://github.com/user-attachments/assets/ecd78d54-097c-4216-9302-1cd37dd3a472" />

