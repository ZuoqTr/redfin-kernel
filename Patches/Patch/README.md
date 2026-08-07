# SUSFS Patch Placeholder

## IMPORTANT: This is a placeholder file

The actual `susfs_patch_to_4.19.patch` needs to be generated from the SUSFS repository.

### How to Generate

1. Clone SUSFS repository:
```bash
git clone https://github.com/5ec1cff/SUSFS.git
cd SUSFS
```

2. Generate patch for kernel 4.19:
```bash
# Check available patches
ls kernel_patches/

# Or create from source
git checkout 1.5.9  # or latest stable tag
```

3. Copy the generated patch to this directory:
```bash
cp kernel_patches/50_add_susfs_in_kernel-4.19.patch Patches/Patch/
```

### Patch Sources

- Official: https://github.com/5ec1cff/SUSFS
- Tags: https://github.com/5ec1cff/SUSFS/tags

### Current Version

- SUSFS: 1.5.9 (or latest)
- Kernel: 4.19

### Note

The patch structure should follow:
```
kernel_patches/
├── KernelSU/
│   └── 10_enable_susfs_for_ksu.patch
└── 50_add_susfs_in_kernel-4.19.patch
```
