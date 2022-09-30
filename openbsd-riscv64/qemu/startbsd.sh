#!/usr/bin/env bash

qemu-system-riscv64 \
                -machine virt \
                -nographic \
                -m 2048M \
                -smp 2 \
                -bios fw_dynamic.bin \
                -kernel u-boot.bin \
                -drive file=bsd.img,format=raw,id=hd0 -device virtio-blk-device,drive=hd0 \
                -netdev user,id=net0,ipv6=off -device virtio-net-device,netdev=net0
