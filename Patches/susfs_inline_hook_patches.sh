#!/bin/bash
# susfs_inline_hook_patches.sh - Apply SUSFS inline hooks for non-GKI kernels
# Reference: https://kernelsu.org/guide/how-to-integrate-for-non-gki.html

KERNEL_ROOT="${1:-.}"

cd "$KERNEL_ROOT"

echo "[+] Applying SUSFS inline hooks for non-GKI..."

# Hook execve in fs/exec.c
# Add hook declarations after includes
if ! grep -q "ksu_handle_execve_sucompat" fs/exec.c 2>/dev/null; then
    echo "[+] Patching fs/exec.c for execve hooks..."

    # Add extern declarations
    sed -i '/^#include <linux\/sched.h>/a\
\
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

    # Add hook calls in SYSCALL_DEFINE3(execve)
    sed -i '/SYSCALL_DEFINE3(execve/,/return do_execve/c\
SYSCALL_DEFINE3(execve,\
\t\tconst char __user *, filename,\
\t\tconst char __user *const __user *, argv,\
\t\tconst char __user *const __user *, envp)\
{\
#ifdef CONFIG_KSU && !defined(CONFIG_KSU_KPROBES_HOOK)\
\tif (unlikely(ksu_execveat_hook))\
\t\tksu_handle_execve_ksud(filename, argv);\
\telse\
\t\tksu_handle_execve_sucompat((int *)AT_FDCWD, \&filename, NULL, NULL, NULL);\
#endif\
\treturn do_execve(getname(filename), argv, envp);\
}
' fs/exec.c

    echo "[+] fs/exec.c patched."
fi

# Hook vfs_open in fs/open.c
if ! grep -q "ksu_vfs_open_hook" fs/open.c 2>/dev/null; then
    echo "[+] Patching fs/open.c for open hooks..."

    sed -i '/^#include <linux\/fs.h>/a\
\
#ifdef CONFIG_KSU && !defined(CONFIG_KSU_KPROBES_HOOK)\
extern int ksu_file_open_hook(struct file *file);\
#endif\
' fs/open.c

    echo "[+] fs/open.c patched."
fi

# Hook vfs_read/vfs_write in fs/read_write.c
if ! grep -q "ksu_vfs_read_hook" fs/read_write.c 2>/dev/null; then
    echo "[+] Patching fs/read_write.c..."

    sed -i '/^#include <linux\/fs.h>/a\
\
#ifdef CONFIG_KSU && !defined(CONFIG_KSU_KPROBES_HOOK)\
extern ssize_t ksu_vfs_read_hook(struct file *file, char __user *buf,\
                                 size_t count, loff_t *pos);\
extern ssize_t ksu_vfs_write_hook(struct file *file, const char __user *buf,\
                                  size_t count, loff_t *pos);\
#endif\
' fs/read_write.c

    echo "[+] fs/read_write.c patched."
fi

# Hook vfs_statx in fs/stat.c
if ! grep -q "ksu_vfs_statx_hook" fs/stat.c 2>/dev/null; then
    echo "[+] Patching fs/stat.c..."

    sed -i '/^#include <linux\/fs.h>/a\
\
#ifdef CONFIG_KSU && !defined(CONFIG_KSU_KPROBES_HOOK)\
extern int ksu_vfs_statx_hook(int dfd, struct filename *name,\
                             unsigned int flags, struct kstat *stat,\
                             unsigned int mnt_id_map);\
#endif\
' fs/stat.c

    echo "[+] fs/stat.c patched."
fi

echo "[+] SUSFS inline hooks patching completed."
echo "[+] Note: Full hook implementation requires KernelSU built-in functions."
