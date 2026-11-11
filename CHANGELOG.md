# Changelog

### November 11, 2026

- Updated Kansas vendor blobs and libraries from firmware `W1VKS36H.9-12-11` to `W1VKS36H.9-12-12`.
- New firmware source: `KANSAS_G_SYS_W1VKS36H.9-12-12_subsidy-DISH_WILD_regulatory-DEFAULT_cid50_CFC`.
- Updated Trustonic/MobiCore components and registry files.
- Retained recovery-specific configuration and existing customizations.

### November 7, 2026

vold: Fix ownership of copied Keystore SQLite database

Updated `Decrypt.cpp` to explicitly set the ownership of copied Keystore SQLite database files to system:system (UID/GID 1000:1000) before applying restrictive permissions (0600). --> that file is my androi_system_vold repo

This ensures Keystore2 can properly access the database during recovery and prevents ownership-related access issues.

Fixed mnt root root to system system and permission 700 to 0771 in init.recovery.mt6835.rc for proper read or keystore would only work partially in recovery twrp

got rid of keystore2.rc no longer needed as it is initialized in init.recovery.mt6835.rc completley now

recovery: Disable TW_WORKAROUND_BACKUP_BUG

Removed the `-DTW_WORKAROUND_BACKUP_BUG` compiler flag from `bootable/recovery/Android.bp`, disabling the conditional backup exclusions and related workarounds in `partition.cpp`.

This restores normal TWRP Data partition size reporting and backup coverage, including `/data/data`, application data, contacts, and other user data that should normally be included in a Data backup.

### November 4, 2026 — TWRP Boot / Trustonic Crypto / FBE

Fixed the TWRP boot path following crypto/TEE initialization changes that caused recovery to get stuck on the boot animation.
Identified a Mobicore service crash caused by setpriority -20 failing when running as the system user; removed the priority setting.
Aligned TEE/crypto services with stock configurations where possible (user system / group system for TEE, KeyMint, Gatekeeper, and keystore2; Mobicore adjusted as needed).
Confirmed persist and tzapp mount paths and trustlet registry paths are present.
Fixed /data mounting so recovery reports a realistic size of approximately 110 GB total and 52 GB used instead of only a few gigabytes.
Confirmed partitions appear correctly under Mount.
Identified the remaining partial FBE issue: /data/media/0 still displays encrypted filenames instead of normal directories such as DCIM and Download.
TWRP continues to report "not all users decrypted," with user 0 decryption failing.
Confirmed that the device has no screen lock, so decryption must complete through the device-key/KeyMint path without PIN entry.

## To Do:

Capture logcat immediately after TWRP boot, focusing on decryption, KeyMint, Gatekeeper, and user 0.
Finish no-password device-key FBE decryption for user 0.
Verify /data/media/0 displays normal directory names (DCIM, Download, Android, etc.).
Confirm Internal Storage (/sdcard) in the TWRP UI matches the expected contents.
Retest Backup without the "not all users decrypted" warning, or document any multi-user limitations.
Check Wipe → Advanced partition list against the Mount list.
Investigate USB OTG for backups because the hardware SD reader is unreliable.
Optionally clean up remaining SELinux denials if they interfere with recovery crypto.


### November 1, 2026 — Independent TWRP Source Development

- Started transitioning Kansas TWRP development to OGDR's own independently maintained `TWRP16_KANSAS` source tree.
- Established a separate source environment for continued TWRP 16.0 development and future recovery versions.
- Preparing the first Kansas recovery build using the independent source tree.
- **Source Repository:** [TWRP16_KANSAS](https://github.com/OGDR/TWRP16_KANSAS/tree/main)

### To Do — Historic Priorities

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
