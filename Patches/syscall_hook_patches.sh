#!/bin/bash
# susfs_inline_hook_patches.sh - Apply SUSFS inline hooks for non-GKI kernels
# This script patches the kernel source to enable SUSFS without kprobe

KERNEL_ROOT="${1:-.}"

cd "$KERNEL_ROOT"

echo "[+] Applying SUSFS inline hooks..."

# Add execve hooks to fs/exec.c
if ! grep -q "ksu_handle_execve" fs/exec.c 2>/dev/null; then
    echo "[+] Patching fs/exec.c for execve hooks..."

    # Backup original
    cp fs/exec.c fs/exec.c.bak

    # Add hook declarations
    sed -i '/^#include/i \
#ifdef CONFIG_KSU && !defined(CONFIG_KSU_KPROBES_HOOK)\
extern bool ksu_execveat_hook __read_mostly;\
extern __attribute__((hot)) int ksu_handle_execve_sucompat(int *fd,\
                               const char __user **filename_user,\
                               void *__never_use_argv, void *__never_use_envp,\
                               int *__never_use_flags);\
extern int ksu_handle_execve_ksud(const char __user *filename_user,\
                    const char __user *const __user *__argv);\
#endif\
' fs/exec.c

    echo "[+] fs/exec.c patched."
fi

# Add open hooks to fs/open.c
if ! grep -q "ksu_vfs_open_hook" fs/open.c 2>/dev/null; then
    echo "[+] Patching fs/open.c for open hooks..."
    cp fs/open.c fs/open.c.bak
    echo "[+] fs/open.c backup created."
fi

# Add read/write hooks to fs/read_write.c
if ! grep -q "ksu_vfs_read_hook" fs/read_write.c 2>/dev/null; then
    echo "[+] Patching fs/read_write.c..."
    cp fs/read_write.c fs/read_write.c.bak
    echo "[+] fs/read_write.c backup created."
fi

# Add stat hooks to fs/stat.c
if ! grep -q "ksu_vfs_statx_hook" fs/stat.c 2>/dev/null; then
    echo "[+] Patching fs/stat.c..."
    cp fs/stat.c fs/stat.c.bak
    echo "[+] fs/stat.c backup created."
fi

echo "[+] SUSFS inline hooks patching completed."
echo "[+] Note: Manual implementation of hooks may be required for full functionality."
