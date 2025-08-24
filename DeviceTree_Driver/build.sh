#!/usr/bin/bash
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
cd linux
make O=out defconfig
make O=out menuconfig
make O=out -j$(nproc) Image modules dtbs