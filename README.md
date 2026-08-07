# Pixel 5 (redfin) Kernel with KernelSU Next + SUSFS

Auto-built kernel for **Pixel 5 (redfin)** running **Android 11 QPR3**.

## Features

- **KernelSU Next** - Root solution with allowlist support
- **SUSFS** - Hide suspicious paths and mounts
- **Manual Hooks** - No kprobe, better compatibility
- **Clang 19.1.7** - Modern compiler

## Build Information

| Item | Value |
|------|-------|
| Device | Pixel 5 |
| Codename | redfin |
| SoC | Snapdragon 765G |
| Kernel | 4.19 |
| Android | 11 QPR3 |
| Compiler | Clang 19.1.7 |

## GitHub Actions

This repository uses GitHub Actions for automatic building and releasing:

- **Schedule**: Every Wednesday at 03:00 UTC
- **Manual**: Trigger via Actions tab

## Downloads

Get pre-built kernels from [GitHub Releases](../../releases).

## Installation

1. Download the flashable zip
2. Boot into recovery (TWRP)
3. Flash the zip
4. Reboot

Or via Fastboot:
```bash
fastboot flash boot boot.img
fastboot reboot
```

## Project Structure

```
├── .github/workflows/
│   ├── build-release.yml      # Main release workflow
│   ├── build-kernel.yml      # Build trigger
│   ├── build-sample.yml       # Device config
│   ├── build-env/action.yml   # Setup env
│   ├── build-ready/action.yml # Clone kernel + tools
│   ├── build-process/        # Compile
│   ├── patch-susfs/          # Patch SUSFS
│   ├── patch-no-kprobe/      # Manual hooks
│   ├── pack-process/         # Pack AK3
│   └── upload-files/         # Upload artifacts
├── Patches/
│   ├── fs/                   # SUSFS fs patches
│   ├── include/linux/        # SUSFS headers
│   ├── KernelSU/             # KernelSU enable patch
│   └── 50_add_susfs_in_kernel-4.19.patch
├── anykernel.sh              # Custom AnyKernel3 script
└── README.md
```

## Build from Source

```bash
# Clone repo
git clone https://github.com/YOUR_USERNAME/redfin-kernel.git
cd redfin-kernel

# Push to GitHub and Actions will build automatically
git push
```

## Credits

- [KernelSU Next](https://github.com/KernelSU-Next/KernelSU-Next)
- [SUSFS](https://gitlab.com/simonpunk/susfs4ksu)
- [AnyKernel3](https://github.com/osm0sis/AnyKernel3)
- [NonGKI Kernel Build](https://github.com/JackA1ltman/NonGKI_Kernel_Build_2nd)
