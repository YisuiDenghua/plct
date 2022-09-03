#!/usr/bin/env bash

qemu-system-riscv64 \
-machine virt -nographic -m 8G -smp 8 \
-bios fw_jump.elf \
-kernel uboot.elf \
-device virtio-net-device,netdev=eth0 -netdev user,id=eth0 \
-drive file=ubuntu-22.04.1-preinstalled-server-riscv64+unmatched.img,format=raw,if=virtio
