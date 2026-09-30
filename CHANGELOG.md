# Changelog

## Kansas TWRP Development

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
* **To Do:** Fix the display rendering issue.

### September 28, 2026 — UI Bring-Up Phase

* Switched the build to focus exclusively on **TWRP UI bring-up and stabilization**.
* Temporarily disabled the crypto, KeyMint, FBE, and related security components from the recovery environment.
* The goal is to avoid attempting to bring up the entire recovery stack simultaneously and instead isolate the UI and basic recovery functionality first.
* **Next Phase:** Once the TWRP UI is fully functional and stable, begin restoring the crypto, KeyMint, FBE, and related components incrementally.
* This staged approach will make it easier to identify and resolve problems as each subsystem is reintroduced.

### September 23, 2026 — Recovery / Decrypt Work

#### Earlier Build — Trustonic Stack into Recovery

* Added the Trustonic TEE, KeyMint, and Gatekeeper binaries under `recovery/root/vendor/bin/hw/`:

  * `vendor.trustonic.tee@1.1-service`
  * `android.hardware.security.keymint@2.0-service.trustonic`
  * `android.hardware.gatekeeper@1.0-service`
* Added the matching init scripts under `recovery/root/vendor/etc/init/`:

  * `tee.rc`
  * `vendor.trustonic.tee@1.1-service.rc`
  * `android.hardware.security.keymint@2.0-service.trustonic.rc`
  * `android.hardware.gatekeeper@1.0-service.rc`
* Added the required Trustonic and Gatekeeper libraries under `recovery/root/vendor/lib64/` and `recovery/root/vendor/lib64/hw/`:

  * `libMcClient.so`
  * `libMcRegistry.so`
  * `vendor.trustonic.tee@1.0.so`
  * `vendor.trustonic.tee@1.1.so`
  * `libkeymint.so`
  * `libkeymaster_messages.so`
  * `gatekeeper.trustonic.so`
  * `libMcGatekeeper.so`
  * `android.hardware.gatekeeper@1.0-impl.so`
* Kept the existing touch modules, firmware, and TWRP recovery layout.
* Fixed the `libbase` `Trim` symbol/link issues using `patchelf`, since TWRP 16 does not support the legacy `LD_SHIM_LIBS` mechanism.

#### Current Build — Service Start Order / Naming Fixes

* Fixed `vendor/etc/init/tee.rc` to start `mobicore` and then `tee-1-1`, matching the service name that actually exists.
* Updated `init.recovery.mt6835.rc` to start the Trustonic services in the proper order:

  1. `tee-1-1`
  2. `vendor.keymint-trustonic`
  3. `vendor.gatekeeper-1-0`
* Changed `keystore2` startup so it waits for KeyMint:

  * `keystore2` now starts after `vendor.keymint-trustonic` reaches the `running` state.
* Disabled the early automatic `keystore2` startup in `system/etc/init/keystore2.rc` by commenting out its `late-init` start, preventing it from racing ahead of KeyMint.

#### Goal

* Prevent the `keystore2` `HARDWARE_TYPE_UNAVAILABLE` abort.
* Enable the Trustonic KeyMint path required for FBE decryption in TWRP.
* Added additional `.so` libraries required by the TEE, crypto, and FBE components and their dependencies.

#### To Do

* Continue adding the remaining required TEE, crypto, and FBE libraries to the recovery environment as dependencies are identified.

### September 22, 2026

* The shims could not be applied using the legacy `TARGET_LD_SHIM_LIBS` mechanism because the required libraries were not being prepared in time.
* Used `patchelf` on the two affected `.so` files to add the required `libbase_shim.so` dependency.
* This allowed the affected libraries to resolve the required symbols from the Android 15 `libbase.so` implementation that Motorola is still using.
* Verified that the previously missing symbols can now be resolved, fixing the compatibility issue.

### September 21, 2026

* Fixed the remaining VINTF compatibility issues.
* Added shims for:

  * `android.hardware.boot@1.0-impl-1.2-mtkimpl.so`
  * `android.hardware.health-service.example_recovery`
* Added the shims to resolve the missing reference symbol:

  * `_ZN7android4base4TrimERKNSt3__112basic_stringIcNS1_11char_traitsIcENS1_9allocatorIcEEEE`

### September 20, 2026

* Fixed the manifest error for `system/etc/vintf/manifest.xml`.

### September 19, 2026

* Figured out the correct stock `vendor_ramdisk00` and the proper format to use alongside the TWRP recovery ramdisk.
* Stock `vendor_ramdisk00` is **0x1** and the TWRP ramdisk is **0x2**.
* Android is booting again with the stock vendor ramdisk and TWRP recovery ramdisk working together.
* Started putting components back into `recovery/root`, placing them back in the proper locations and structure.
* **To Do:** Determine exactly what needs to be restored to `recovery/root` so the stock vendor ramdisk and TWRP recovery ramdisk boot together in sync without starting the previous boot loop.

### September 18, 2026

* Fixed the Kansas board configuration.
* Board configuration is now correct.
* Shrunk the stock vendor_boot CPIO and compressed it to `.lz4`, reducing it to approximately **27 MB**.

### September 17, 2026

* Added `build/tools/vendor_boot.mk`.
* Updated the build process so the stock `vendor_boot` CPIO ramdisk is placed into the generated vendor_boot image.

### Early September 2026

* Switched from **TWRP 14.1** to the **TWRP 16 test branch** so the `init` executable could be built correctly and fix the broken `init` symlink.

### Early September 2026 — Android Boot

* The Android system successfully booted from the ongoing Kansas TWRP development work.
* This confirmed that the vendor_boot and recovery ramdisk configuration was progressing toward a working recovery environment.

### July 23, 2026 — Initial Development

* Began Kansas TWRP development.
* Initial build and device bring-up work started.
* The first build did **not** boot; subsequent development focused on identifying the vendor_boot, ramdisk, BoardConfig, and recovery environment requirements needed to reach a booting configuration.
