# Changelog

## Kansas TWRP Development

### October 8, 2026 — 1:55 PM — MTK Boot Implementation Working

* **TWRP now boots successfully** with the new MTK boot implementation **`android.hardware.boot@1.0-impl-1.2-mtkimpl.so`**.
* Fixed a line in the **boot implementation source** that was preventing it from working correctly.
* Fixed the reason the boot implementation was not compiling, which was caused by how the source path was set up in **`device.mk`**.
* The new ported MTK boot implementation is now working well enough for TWRP to boot.

#### To Do

1. Fix anything reported in the **new recovery log**.
2. Continue fixing anything that appears in **future logs** as the remaining boot issues are worked out.
3. Clean up the recovery environment once the logs are clean.
4. After cleanup, begin adding what is required for **data decryption**.

### October 8, 2026 — MTK Boot Implementation

* Soong now creates the required components; had to add the **source path in `device.mk`**.
* Added **`libbase` as a shared library in `Android.bp`** to provide the required symbol declaration.
* Added the **`bootctl` directory** to the device tree to supply the **ported codebase for the MTK boot implementation**.
* The ported MTK boot implementation for **`android.hardware.boot@1.0-impl-1.2-mtkimpl.so`** now finally compiles successfully.
* Next step was to **install clean**, then build again and take a fresh recovery log.
* Once the new build was tested, the remaining issues would be fixed to get **TWRP booting again**.
* Because some things changed with the new boot implementation, some previously made changes may need to be restored or adjusted.
* Some **HIDL components may need to be put back**, but that will not be known until the build is complete and a new log is taken.
* The immediate goal was to test the working MTK boot implementation source, capture the new log, and continue from whatever the completed build reports.

### October 7, 2026 — Boot HAL / BCB Investigation

* The crash found in last night's dump was occurring in **`get_misc_blk_device()`** while the MTK boot HAL was trying to locate the `/misc` block device.
* The crash was traced to the Motorola prebuilt MTK boot HAL being built against an older **`FstabEntry` ABI/layout (`0x1a8`)**, while Android 16 uses the newer **`FstabEntry` layout (`0x268`)**.
* This issue led to the investigation of the **MTK boot implementation**.
* Moved the boot entries into the **vendor manifest** in an attempt to fix the issue.
* Deleted the existing `.so`, and I am making my own replacement using **ported code from another device for the MTK boot implementation**.
* Building and testing the changes now.
* If this does not work, I will have to **recode small portions of the MTK boot implementation** for the Moto G 5G 2025.

### October 5, 2026 — Recovery / VINTF Fixes

* Fixed the issues introduced by switching the recovery fstab back to the **5-field format**.
* Addressed the resulting **VINTF, manifest, boot implementation, and other recovery errors**.
* Added `android.hardware.health@2.1` as required to resolve the health HAL compatibility issue.
* All identified VINTF, manifest, boot, and related recovery issues have now been addressed.
* **Current Issue:** Fixing BCB handling caused by AIDL not transitioning back to the **HIDL state**.
* The BCB issue currently causes recovery to continuously restart, resulting in the device becoming stuck at the **Motorola manufacturer logo**.
* **To Do:** Fix the BCB/AIDL-to-HIDL recovery restart issue so TWRP can complete its boot process normally.

### October 4, 2026 — Recovery Fstab

* Switched the recovery fstab back to the **5-field format** required by TWRP.
* This restored the recovery fstab structure to match the expected TWRP format.

### September 30, 2026 — UI / Recovery Functionality

* Fixed the display rendering issue.
* TWRP UI now displays clearly with **HD-quality image clarity**.
* Added the required **task profiles** to the recovery environment.
* **ADB is now working** in TWRP.
* Battery percentage is now displayed correctly in TWRP.
* **Battery charging now works while in TWRP**.

#### To Do

* Fix the remaining recovery log issues related to the **boot implementation**.
* Clean up the remaining recovery log errors and warnings after the boot implementation issues are resolved.
* Fix **reboot to Android** from TWRP. Currently, rebooting from TWRP does not boot Android directly; the device must first be booted into the bootloader and then Android.
* Add **fastbootd** support.
* Get **fastbootd fully working** in TWRP.

### September 29, 2026 — UI Bring-Up

* TWRP UI bring-up now **boots successfully**.
* **Touchscreen is working**.

### September 28, 2026 — UI Bring-Up Phase

* Switched build to focus exclusively on TWRP UI bring-up/stabilization.
* Temporarily disabled crypto, KeyMint, FBE, and related security components.
* Once UI is stable, restore crypto/KeyMint/FBE incrementally.

### September 23, 2026 — Recovery / Decrypt Work

* Trustonic TEE/KeyMint/Gatekeeper binaries, init scripts, and libraries added; touch modules/firmware kept.
* `libbase` Trim symbol/link issues fixed using `patchelf`.
* Fixed service start order and `keystore2` startup dependency.
* Goal: prevent KeyMint/keystore2 abort and enable the FBE path later.
* To Do: continue adding required TEE/crypto/FBE libraries as dependencies are identified.

### September 22, 2026

* Legacy `TARGET_LD_SHIM_LIBS` could not be used; `patchelf` added `libbase_shim.so` dependency to two affected `.so` files.
* Verified missing symbols resolve against Android 15 Motorola `libbase.so`.

### September 21, 2026

* Fixed remaining VINTF issues.
* Added shims for boot implementation and health service.
* Added shims for missing `android::base::Trim` symbol.

### September 20, 2026

* Fixed `system/etc/vintf/manifest.xml` manifest error.

### September 19, 2026

* Correct stock `vendor_ramdisk00` and format found; stock `0x1` + TWRP `0x2`.
* Android booting again with stock vendor ramdisk + TWRP recovery ramdisk.
* Started restoring components into `recovery/root` in proper locations.
* To Do: restore needed components in sync without boot loop.

### September 18, 2026

* Fixed Kansas BoardConfig.
* Shrunk stock vendor_boot CPIO to approximately 27 MB and compressed to `.lz4`.

### September 17, 2026

* Added `build/tools/vendor_boot.mk` to place the stock vendor_boot CPIO into the generated vendor_boot.

### Early September 2026

* Switched from TWRP 14.1 to the TWRP 16 test branch for the correct `init` executable and to resolve the broken `init` symlink.

### Early September 2026 — Android Boot

* Android successfully booted from the ongoing Kansas TWRP work.

### July 23, 2026 — Initial Development

* Began Kansas TWRP development.
* Initial build/device bring-up started.
* First build did not boot; later work focused on vendor_boot, ramdisk, BoardConfig, and the recovery environment.
