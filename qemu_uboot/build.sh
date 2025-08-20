#!/usr/bin/bash
cd u-boot
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
make qemu_arm64_defconfig
make -j$(nproc)

cd ../linux
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
make defconfig
make -j$(nproc) Image

cd ../busybox
make defconfig
sed -ri 's/^# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config
sed -ri 's/^CONFIG_TC=y/# CONFIG_TC is not set/' .config
make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
make CONFIG_PREFIX=$PWD/_rootfs CROSS_COMPILE=aarch64-linux-gnu- install

cd _rootfs
mkdir -p {proc,sys,dev,etc}
# file /init (shebang sh)
cat > init <<'EOF'
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev
echo ">> initramfs up. Spawning shell..."
exec sh
EOF
chmod +x init
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../../rootfs.cpio.gz
cd ../..

mkdir -p ${HOME}/tftp
cp rootfs.cpio.gz ${HOME}/tftp/
cd linux
cp arch/arm64/boot/Image ${HOME}/tftp/
# cp arch/arm64/boot/dts/arm/virt.dtb ${HOME}/tftp/

cd ..
mkimage -A arm64 -T script -C none -d boot.cmd boot.scr
cp boot.scr ${HOME}/tftp/

cd u-boot
qemu-system-aarch64 -M virt -cpu cortex-a57 -m 1024 -nographic -bios u-boot.bin \
-net nic -net user,tftp=${HOME}/tftp