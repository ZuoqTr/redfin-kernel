# Supported Device List

| Device Name | Codename | SoC | Kernel | System | Android | Status |
|------------|----------|-----|--------|--------|---------|--------|
| Pixel 5 | redfin | Snapdragon 765G | 4.19 | Android 11 QPR3 | 11 | ✅ Supported |

## Installation

### Method 1: Custom Recovery (Recommended)
1. Download the latest release from GitHub Releases
2. Boot into custom recovery (TWRP, OrangeFox, etc.)
3. Flash the `Kernel-redfin-KSU-SUSFS.zip`
4. Reboot

### Method 2: Fastboot
1. Download boot.img from releases
2. Boot into fastboot mode: `adb reboot bootloader`
3. Flash: `fastboot flash boot boot.img`
4. Reboot: `fastboot reboot`

## Features

- **KernelSU Next**: Root solution with allowlist support
- **SUSFS**: Hide solution for systemless modifications
- **No Kprobe**: Uses manual hooks for better compatibility
- **AnyKernel3**: Flashable via recovery

## Changelog

### v1.0.0
- Initial release with KernelSU Next + SUSFS
- Based on `android-msm-redfin-4.19-android11-qpr3`
- Clang 19.1.7 build
