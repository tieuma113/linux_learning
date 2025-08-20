# Linux Boot Sequence Learning Project

This project is designed to help understand the Linux boot sequence by implementing a minimal Linux system using QEMU, U-Boot bootloader, BusyBox userspace utilities, and the Linux kernel.

## Project Structure

```
.
├── qemu_uboot/          # QEMU and U-Boot configuration
│   ├── boot.cmd         # U-Boot boot commands
│   ├── build.sh         # Build script
│   ├── setup.sh         # Setup script
│   ├── busybox/        # BusyBox source and build files
│   ├── linux/          # Linux kernel source
│   └── u-boot/         # U-Boot bootloader source
```

## Components

### 1. U-Boot Bootloader
- Located in `qemu_uboot/u-boot/`
- Responsible for initial hardware initialization
- Loads and passes control to the Linux kernel

### 2. Linux Kernel
- Located in `qemu_uboot/linux/`
- Core operating system kernel
- Handles hardware abstraction, process management, and system calls

### 3. BusyBox
- Located in `qemu_uboot/busybox/`
- Provides essential Unix utilities
- Creates a minimal root filesystem (`_rootfs/`)

## Build Instructions

1. Run the setup script to prepare the environment:
   ```bash
   cd qemu_uboot
   ./setup.sh
   ```

2. Build the system components:
   ```bash
   ./build.sh
   ```

## Boot Sequence Overview

1. **QEMU Start**
   - QEMU emulates the hardware platform
   - Loads U-Boot into memory

2. **U-Boot Stage**
   - Initializes hardware
   - Loads boot configuration from `boot.cmd`
   - Loads Linux kernel into memory

3. **Linux Kernel Boot**
   - Kernel initializes
   - Mounts root filesystem
   - Starts init process

4. **BusyBox Init**
   - Mounts virtual filesystems (/proc, /sys, /dev)
   - Sets up system environment
   - Launches shell

## Directory Structure Details

### Root Filesystem (`busybox/_rootfs/`)
```
├── bin/     # Essential command binaries
├── dev/     # Device files
├── etc/     # System configuration
├── proc/    # Process information
├── sbin/    # System binaries
├── sys/     # Kernel information
└── usr/     # User utilities
```

## Learning Objectives

1. Understanding the boot process from power-on to user space
2. Learning about bootloader operations and configurations
3. Exploring kernel initialization and hardware detection
4. Understanding minimal root filesystem requirements
5. Learning about init process and system initialization


## License

Please refer to individual component licenses:
- Linux Kernel: GPL-2.0
- U-Boot: GPL-2.0
- BusyBox: GPL-2.0