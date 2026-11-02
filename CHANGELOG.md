# Changelog

### November 1, 2026 — Independent TWRP Source Development

- Started transitioning Kansas TWRP development to OGDR's own independently maintained `TWRP16_KANSAS` source tree.
- Established a separate source environment for continued TWRP 16.0 development and future recovery versions.
- Preparing the first Kansas recovery build using the independent source tree.
- **Source Repository:** [TWRP16_KANSAS](https://github.com/OGDR/TWRP16_KANSAS/tree/main)

### To Do — Current Priorities

1. **Partition visibility:** Investigate why System, Vendor, and Product do not appear in Advanced Wipe.
2. **Backup size calculation:** Investigate why Data initially reports 7.78 GB and reports 16.3 GB after selecting **Refresh Sizes**, despite stock showing approximately 110 GB total.
3. **Recovery cleanup:** Clean up the recovery environment once the remaining functional issues are resolved.
4. **Independent source repository:** After the new source build is successfully tested and boots, update the `TWRP16_KANSAS` source repository with the completed build and development information.

### October 26, 2026 — Data Decryption / Mount Fixes / Recovery Init

- Completed `/data` decryption support in TWRP.
- Confirmed that `/data` mounts successfully and reports its size, with encrypted data accessible in recovery.
- Fixed the mounts for `/mnt/vendor/persist` and `/mnt/vendor/persist/mcRegistry`.
- Added the `/mnt/vendor/persist/mobicore` mount.
- Corrected SELinux labeling for `/mnt/vendor/persist` and its `mobicore` subdirectory.
- Disabled `keystore2.rc` and enabled a customized KeyStore configuration through `init.recovery.mt6835.rc` for TWRP recovery.
- Identified partition visibility and backup size calculation issues during post-build testing.

#### Historical To Do Items

- Completed `/data` decryption support and verified that the encrypted data partition mounts successfully.
- Integrated and troubleshot Trustonic KeyMint and the remaining Trustonic/FBE requirements.
- Corrected SELinux labeling for `/mnt/vendor/tzapp` and `/mnt/vendor/persist`.
- Resolved SELinux policy build issues, restored `restorecon` functionality, and continued correcting file contexts, type definitions, and policy rules.

### October 25, 2026 — HIDL / AIDL Service Fixes

- Fixed a bug related to the HIDL service manager and service registration that was introduced by a repository sync.
- Fixed the source issue and rebuilt to verify the changes.
- Moved AIDL service fragments from the vendor location into the system location through individual build and test cycles.
- Confirmed that TWRP expects these AIDL service fragments under system for this setup.

### October 24, 2026 — SELinux File Contexts

- Corrected SELinux labeling for `/mnt/vendor/tzapp`, replacing rootfs-related labeling with the appropriate vendor data file context.

### October 23, 2026 — SELinux Policy / Trustonic

- Fixed additional SELinux type definitions and policy rules for the recovery environment.
- Continued refining policy for Trustonic and its associated security components.

### October 22, 2026 — SELinux Policy

- Fixed additional SELinux type definitions and policy rules.
- Continued improving SELinux labeling and support for Trustonic components in recovery.

### October 21, 2026 — SELinux Policy

- Fixed additional SELinux type definitions and policy rules.
- Continued policy cleanup for Trustonic TEE, Gatekeeper, KeyMint, and related components.

### October 20, 2026 — SELinux Policy / Trustonic

- Continued adding SELinux type definitions and policy rules.
- Added more Trustonic TAs and drivers associated with McRegistry.

### October 19, 2026 — SELinux Policy / File Contexts

- Added and corrected SELinux policy rules for Trustonic TEE, Gatekeeper, KeyMint, and related security components.
- Restored `restorecon` functionality and corrected most rootfs file-context mislabeling so files receive their proper SELinux labels.

### October 18, 2026 — SELinux Policy Build Fix

- Fixed the issue preventing SELinux policy from being appended to the `out` build output.

### Kansas TWRP Development

**Project Status — October 14, 2026**

- UI bring-up and stabilization are complete.
- MTK boot implementation integration is complete.
- Core recovery functionality is working, including display, touchscreen, ADB, charging, battery reporting, and fastbootd.
- The remaining major milestone is Android File-Based Encryption (FBE) decryption and reliable `/data` mounting.
- Trustonic TEE/KeyMint startup and its SELinux labeling issues are being investigated as part of restoring the crypto and FBE path.
- Successful decryption and access to user data remain the final major functional objective for completing the Kansas TWRP project.

### October 14, 2026 — Recovery Init Cleanup and Trustonic Startup

- Cleaned up `init.recovery.mt6835.rc`, removing unnecessary items that were no longer needed.
- Reorganized the init configuration so the recovery setup and service startup sequence are arranged in the intended order.
- Added the required directory creation and mount setup for the recovery environment, including the persist and Trustonic tzapp paths.
- Integrated the Mobicore → Trustonic TEE → KeyMint startup sequence, with keystore2 started after KeyMint reports running.
- Kept the Gatekeeper service configured separately from the TEE/KeyMint/keystore2 dependency chain.
- Continued investigating SELinux denials that prevent the Trustonic KeyMint service from loading its shared-library dependencies.

Added the following lines to `init.recovery.mt6835.rc` immediately before `start mobicore`:

```bash
restorecon_recursive /system
restorecon_recursive /vendor
```

**Purpose:** Apply the existing SELinux file-context mappings recursively before the Mobicore → TEE → KeyMint startup chain begins. This is intended to correct files incorrectly labeled rootfs, including libraries KeyMint needs.

**Status:** Pending rebuild and testing. The running recovery still showed an AVC denial for `libcrypto.so` labeled rootfs; the new init change must be built and booted before its effect can be evaluated.

### October 13, 2026 — Novatek Touchscreen Delay Reduced

- Modified the prebuilt `nova_0flash_mmi_v3.ko` to reduce the touchscreen firmware-update delay from 12 seconds to 9 seconds to 6 seconds.
- Successfully booted TWRP with the modified kernel module and verified that touchscreen functionality still works.
- Reduced the observed delay before touch becomes responsive from approximately 12 seconds to around 4–5 seconds after the TWRP interface appears.
- The modified six-second module is now the working baseline for future TWRP development.

### October 8, 2026 — 1:55 PM — MTK Boot Implementation Working

- TWRP now boots successfully with the new MTK boot implementation `android.hardware.boot@1.0-impl-1.2-mtkimpl.so`.
- Fixed a line in the boot implementation source that was preventing it from working correctly.
- Fixed the reason the boot implementation was not compiling, which was caused by how the source path was set up in `device.mk`.
- The new ported MTK boot implementation is now working well enough for TWRP to boot.

**Side Note:** TWRP uses health HAL @2.1.

**Side Note:** Change line 740 in `bootable/recovery/data.cpp` from true to false so MTP is not enabled by default but can still be enabled using the toggle: `persist_["tw_mtp_enabled"] = false;`

### October 8, 2026 — MTK Boot Implementation

- Soong now creates the required components; had to add the source path in `device.mk`.
- Added `libbase` as a shared library in `Android.bp` to provide the required symbol declaration.
- Added the bootctl directory to the device tree to supply the ported codebase for the MTK boot implementation.
- The ported MTK boot implementation for `android.hardware.boot@1.0-impl-1.2-mtkimpl.so` now finally compiles successfully.
- Next step was to install clean, then build again and take a fresh recovery log.
- Once the new build was tested, the remaining issues would be fixed to get TWRP booting again.
- Because some things changed with the new boot implementation, some previously made changes may need to be restored or adjusted.
- Some HIDL components may need to be put back, but that would not be known until the build was complete and a new log was taken.
- The immediate goal was to test the working MTK boot implementation source, capture the new log, and continue from whatever the completed build reported.

### October 7, 2026 — Boot HAL / BCB Investigation

- The crash found in the previous night's dump was occurring in `get_misc_blk_device()` while the MTK boot HAL was trying to locate the `/misc` block device.
- The crash was traced to the Motorola prebuilt MTK boot HAL being built against an older FstabEntry ABI/layout (0x1a8), while Android 16 uses the newer FstabEntry layout (0x268).
- This issue led to the investigation of the MTK boot implementation.
- Moved the boot entries into the vendor manifest in an attempt to fix the issue.
- Deleted the existing `.so` and began making a replacement using ported code from another device for the MTK boot implementation.
- Built and tested the changes.
- If the replacement did not work, the next step would be to recode small portions of the MTK boot implementation for the Moto G 5G 2025.

### October 5, 2026 — Recovery / VINTF Fixes

- Fixed the issues introduced by switching the recovery fstab back to the 5-field format.
- Addressed the resulting VINTF, manifest, boot implementation, and other recovery errors.
- Added `android.hardware.health@2.1` as required to resolve the health HAL compatibility issue.
- Addressed the identified VINTF, manifest, boot, and related recovery issues.
- Issue under investigation: BCB handling associated with AIDL not transitioning back to the HIDL state.
- The BCB issue caused recovery to continuously restart, leaving the device stuck at the Motorola manufacturer logo.

**Historical To Do:** Resolve the BCB/AIDL-to-HIDL recovery restart issue so TWRP can complete its boot process normally.

### October 4, 2026 — Recovery Fstab

- Switched the recovery fstab back to the 5-field format required by TWRP.
- Restored the recovery fstab structure to match the expected TWRP format.

### September 30, 2026 — UI / Recovery Functionality

- Fixed the display rendering issue.
- TWRP UI now displays clearly with HD-quality image clarity.
- Added the required task profiles to the recovery environment.
- ADB is now working in TWRP.
- Battery percentage is now displayed correctly in TWRP.
- Battery charging now works while in TWRP.

**Historical To Do:**

- Resolve any remaining recovery log issues related to the boot implementation.
- Review remaining recovery log errors and warnings after the boot implementation issues are resolved.
- Fix reboot to Android from TWRP. Currently, rebooting from TWRP does not boot Android directly; the device must first be booted into the bootloader and then Android.
- Add and test fastbootd support.

### September 29, 2026 — UI Bring-Up

- TWRP UI bring-up now boots successfully.
- Touchscreen is working.

### September 28, 2026 — UI Bring-Up Phase

- Switched the build to focus exclusively on TWRP UI bring-up and stabilization.
- Temporarily disabled crypto, KeyMint, FBE, and related security components.
- Planned to restore crypto, KeyMint, and FBE incrementally once the UI was stable.

### September 23, 2026 — Recovery / Decrypt Work

- Trustonic TEE/KeyMint/Gatekeeper binaries, init scripts, and libraries added; touch modules and firmware kept.
- `libbase` Trim symbol/link issues fixed using patchelf.
- Fixed service start order and the keystore2 startup dependency.
- Goal: prevent KeyMint/keystore2 aborts and enable the FBE path later.

**Historical To Do:** Continue adding required TEE/crypto/FBE libraries as dependencies are identified.

### September 22, 2026

- Legacy `TARGET_LD_SHIM_LIBS` could not be used; patchelf added the `libbase_shim.so` dependency to two affected `.so` files.
- Verified that the missing symbols resolve against Android 15 Motorola `libbase.so`.

### September 21, 2026

- Fixed remaining VINTF issues.
- Added shims for the boot implementation and health service.
- Added shims for the missing `android::base::Trim` symbol.

### September 20, 2026

- Fixed the `system/etc/vintf/manifest.xml` manifest error.

### September 19, 2026

- Identified the correct stock `vendor_ramdisk00` and format; stock 0x1 plus TWRP 0x2.
- Android booting again with the stock vendor ramdisk plus the TWRP recovery ramdisk.
- Started restoring components into recovery/root in their proper locations.

**Historical To Do:** Restore required components in sync without causing a boot loop.

### September 18, 2026

- Fixed Kansas BoardConfig.
- Shrunk the stock vendor_boot CPIO to approximately 27 MB and compressed it to `.lz4`.

### September 17, 2026

- Added `build/tools/vendor_boot.mk` to place the stock vendor_boot CPIO into the generated vendor_boot.

### Early September 2026

- Switched from TWRP 14.1 to the TWRP 16 test branch to obtain the correct init executable and resolve the broken init symlink.

### Early September 2026 — Android Boot

- Android successfully booted from the ongoing Kansas TWRP development work.

### July 23, 2026 — Initial Development

- Began Kansas TWRP development.
- Initial build and device bring-up started.
- The first build did not boot; later work focused on vendor_boot, ramdisk, BoardConfig, and the recovery environment.
