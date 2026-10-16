# Changelog

## To Do — Current Priorities

1. **Test the recovery SELinux relabeling change.** Rebuild TWRP and boot the updated recovery; verify whether `restorecon_recursive` fixes the incorrect `rootfs` labels blocking Trustonic KeyMint.
2. **Get Trustonic KeyMint running reliably.** Continue from the latest AVC denials and service logs without adding broad SELinux permissions unnecessarily.
3. **Resolve the remaining Trustonic TEE issues.** Investigate `/dev/mobicore`, trustlet loading, and the invalid `persist_mobicore_data_file` context after the KeyMint dependency issue is addressed.
4. **Fix anything reported in new recovery logs** as the remaining boot and service issues are worked out.
5. **Investigate and implement Android File-Based Encryption (FBE) decryption and reliable `/data` mounting.**
6. Clean up the recovery environment once the remaining functional issues are resolved.

---

## Kansas TWRP Development

### Project Status — October 14, 2026

* **UI bring-up and stabilization are complete.**
* **MTK boot implementation integration is complete.**
* Core recovery functionality is working, including display, touchscreen, ADB, charging, battery reporting, and fastbootd.
* The remaining major milestone is **Android File-Based Encryption (FBE) decryption and reliable `/data` mounting**.
* Trustonic TEE/KeyMint startup and its SELinux labeling issues are being investigated as part of restoring the crypto and FBE path.
* Successful decryption and access to user data remain the final major functional objective for completing the Kansas TWRP project.

### October 14, 2026 — Recovery Init Cleanup and Trustonic Startup

* Cleaned up `init.recovery.mt6835.rc`, removing unnecessary items that were no longer needed.
* Reorganized the init configuration so the recovery setup and service startup sequence are arranged in the intended order.
* Added the required directory creation and mount setup for the recovery environment, including the persist and Trustonic `tzapp` paths.
* Integrated the Mobicore → Trustonic TEE → KeyMint startup sequence, with `keystore2` started after KeyMint reports running.
* Kept the Gatekeeper service configured separately from the TEE/KeyMint/`keystore2` dependency chain.
* Continued investigating SELinux denials that prevent the Trustonic KeyMint service from loading its shared-library dependencies.
* Added the following lines to `init.recovery.mt6835.rc` immediately before `start mobicore`:

  ```rc
  restorecon_recursive /system
  restorecon_recursive /vendor
  ```

* **Purpose:** Apply the existing SELinux file-context mappings recursively before the Mobicore → TEE → KeyMint startup chain begins. This is intended to correct files incorrectly labeled `rootfs`, including libraries KeyMint needs.
* **Status: Pending rebuild and testing.** The running recovery still showed an AVC denial for `libcrypto.so` labeled `rootfs`; the new init change must be built and booted before its effect can be evaluated.

### October 13, 2026 — Novatek Touchscreen Delay Reduced

* **Modified the prebuilt `nova_0flash_mmi_v3.ko`** to reduce the touchscreen firmware-update delay from **12 seconds to 9 seconds to 6 seconds**.
* Successfully booted TWRP with the modified kernel module and verified that touchscreen functionality still works.
* Reduced the observed delay before touch becomes responsive from approximately **12 seconds to around 4–5 seconds after the TWRP interface appears**.
* The modified six-second module is now the working baseline for future TWRP development.

### October 8, 2026 — 1:55 PM — MTK Boot Implementation Working

* **TWRP now boots successfully** with the new MTK boot implementation **`android.hardware.boot@1.0-impl-1.2-mtkimpl.so`**.
* Fixed a line in the **boot implementation source** that was preventing it from working correctly.
* Fixed the reason the boot implementation was not compiling, which was caused by how the source path was set up in **`device.mk`**.
* The new ported MTK boot implementation is now working well enough for TWRP to boot.

Side Note: TWRP uses health HAL `@2.1`.

Side Note: Change line 740 in `bootable/recovery/data.cpp` from `true` to `false` so MTP is not enabled by default but can still be enabled using the toggle: `persist_["tw_mtp_enabled"] = false;`

### October 8, 2026 — MTK Boot Implementation

* Soong now creates the required components; had to add the **source path in `device.mk`**.
* Added **`libbase` as a shared library in `Android.bp`** to provide the required symbol declaration.
* Added the **`bootctl` directory** to the device tree to supply the **ported codebase for the MTK boot implementation**.
* The ported MTK boot implementation for **`android.hardware.boot@1.0-impl-1.2-mtkimpl.so`** now finally compiles successfully.
* Next step was to **install clean**, then build again and take a fresh recovery log.
* Once the new build was tested, the remaining issues would be fixed to get **TWRP booting again**.
* Because some things changed with the new boot implementation, some previously made changes may need to be restored or adjusted.
* Some **HIDL components may need to be put back**, but that would not be known until the build was complete and a new log was taken.
* The immediate goal was to test the working MTK boot implementation source, capture the new log, and continue from whatever the completed build reported.

### October 7, 2026 — Boot HAL / BCB Investigation

* The crash found in the previous night's dump was occurring in **`get_misc_blk_device()`** while the MTK boot HAL was trying to locate the `/misc` block device.
* The crash was traced to the Motorola prebuilt MTK boot HAL being built against an older **`FstabEntry` ABI/layout (`0x1a8`)**, while Android 16 uses the newer **`FstabEntry` layout (`0x268`)**.
* This issue led to the investigation of the **MTK boot implementation**.
* Moved the boot entries into the **vendor manifest** in an attempt to fix the issue.
* Deleted the existing `.so` and began making a replacement using **ported code from another device for the MTK boot implementation**.
* Built and tested the changes.
* If the replacement did not work, the next step would be to **recode small portions of the MTK boot implementation** for the Moto G 5G 2025.

### October 5, 2026 — Recovery / VINTF Fixes

* Fixed the issues introduced by switching the recovery fstab back to the **5-field format**.
* Addressed the resulting **VINTF, manifest, boot implementation, and other recovery errors**.
* Added `android.hardware.health@2.1` as required to resolve the health HAL compatibility issue.
* Addressed the identified VINTF, manifest, boot, and related recovery issues.
* **Issue under investigation:** BCB handling associated with AIDL not transitioning back to the **HIDL state**.
* The BCB issue caused recovery to continuously restart, leaving the device stuck at the **Motorola manufacturer logo**.
* **Historical To Do:** Resolve the BCB/AIDL-to-HIDL recovery restart issue so TWRP can complete its boot process normally.

### October 4, 2026 — Recovery Fstab

* Switched the recovery fstab back to the **5-field format** required by TWRP.
* Restored the recovery fstab structure to match the expected TWRP format.

### September 30, 2026 — UI / Recovery Functionality

* Fixed the display rendering issue.
* TWRP UI now displays clearly with **HD-quality image clarity**.
* Added the required **task profiles** to the recovery environment.
* **ADB is now working** in TWRP.
* Battery percentage is now displayed correctly in TWRP.
* **Battery charging now works while in TWRP**.

Historical To Do:
* Resolve any remaining recovery log issues related to the **boot implementation**.
* Review remaining recovery log errors and warnings after the boot implementation issues are resolved.
* Fix **reboot to Android** from TWRP. Currently, rebooting from TWRP does not boot Android directly; the device must first be booted into the bootloader and then Android.
* Add and test **fastbootd** support.

### September 29, 2026 — UI Bring-Up

* TWRP UI bring-up now **boots successfully**.
* **Touchscreen is working**.

### September 28, 2026 — UI Bring-Up Phase

* Switched the build to focus exclusively on TWRP UI bring-up and stabilization.
* Temporarily disabled crypto, KeyMint, FBE, and related security components.
* Planned to restore crypto, KeyMint, and FBE incrementally once the UI was stable.

### September 23, 2026 — Recovery / Decrypt Work

* Trustonic TEE/KeyMint/Gatekeeper binaries, init scripts, and libraries added; touch modules and firmware kept.
* `libbase` Trim symbol/link issues fixed using `patchelf`.
* Fixed service start order and the `keystore2` startup dependency.
* Goal: prevent KeyMint/`keystore2` aborts and enable the FBE path later.
* Historical To Do: continue adding required TEE/crypto/FBE libraries as dependencies are identified.

### September 22, 2026

* Legacy `TARGET_LD_SHIM_LIBS` could not be used; `patchelf` added the `libbase_shim.so` dependency to two affected `.so` files.
* Verified that the missing symbols resolve against Android 15 Motorola `libbase.so`.

### September 21, 2026

* Fixed remaining VINTF issues.
* Added shims for the boot implementation and health service.
* Added shims for the missing `android::base::Trim` symbol.

### September 20, 2026

* Fixed the `system/etc/vintf/manifest.xml` manifest error.

### September 19, 2026

* Identified the correct stock `vendor_ramdisk00` and format; stock `0x1` plus TWRP `0x2`.
* Android booting again with the stock vendor ramdisk plus the TWRP recovery ramdisk.
* Started restoring components into `recovery/root` in their proper locations.
* Historical To Do: restore required components in sync without causing a boot loop.

### September 18, 2026

* Fixed Kansas BoardConfig.
* Shrunk the stock vendor_boot CPIO to approximately 27 MB and compressed it to `.lz4`.

### September 17, 2026

* Added `build/tools/vendor_boot.mk` to place the stock vendor_boot CPIO into the generated vendor_boot.

### Early September 2026

* Switched from TWRP 14.1 to the TWRP 16 test branch to obtain the correct `init` executable and resolve the broken `init` symlink.

### Early September 2026 — Android Boot

* Android successfully booted from the ongoing Kansas TWRP development work.

### July 23, 2026 — Initial Development

* Began Kansas TWRP development.
* Initial build and device bring-up started.
* The first build did not boot; later work focused on vendor_boot, ramdisk, BoardConfig, and the recovery environment.
