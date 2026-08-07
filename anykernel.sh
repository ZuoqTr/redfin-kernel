### AnyKernel3 Ramdisk Mod Script
### For Pixel 5 (redfin) - Android 11

properties() { '
kernel.string=KSU-Next+SUSFS Pixel 5
kernel.compiler=clang
kernel.arch=arm64
kernel.target=boot
kernel.dtbo=dtbo.img
do.devicecheck=1
device.name1=redfin
device.name2=sargo
device.name3=bonito
device.name4=coral
is_slot_device=auto;
block=auto;
initd=auto;
patch_vbmeta_flag=auto;
'; }

# boot image installation
block=boot;
is_slot_device=1;
. tools/ak3-core.sh;
split_boot;
flash_boot;

# vendor_kernel_boot installation (for dtb)
block=vendor_kernel_boot;
is_slot_device=1;
reset_ak;
split_boot;
flash_boot;
