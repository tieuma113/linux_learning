# boot.cmd (ARM64 + QEMU virt + TFTP nội bộ)
setenv serverip 10.0.2.2
setenv ipaddr   10.0.2.15

# tải kernel Image vào địa chỉ mặc định
tftpboot ${kernel_addr_r} Image

# add rootfs
tftpboot ${ramdisk_addr_r} rootfs.cpio.gz
setenv initrd_size ${filesize}
setenv bootargs "console=ttyAMA0 rdinit=/init"

# dùng FDT mà U-Boot đang giữ (QEMU cấp sẵn)
booti ${kernel_addr_r} ${ramdisk_addr_r}:${initrd_size} ${fdtcontroladdr}
