#!/usr/bin/env bash

# The script is created for starting a riscv64 qemu virtual machine with specific parameters on WSL on Windows 10

## Configuration
vcpu=8
memory=8
ssh_port=12055
vnc_port=12056
memory_append=`expr $memory \* 1024`
drive="ubuntu-22.04.1-preinstalled-server-riscv64+unmatched.img"

cmd="qemu-system-riscv64 \
  -machine virt -nographic -m "$memory"G -smp "$vcpu" \
  -bios fw_jump.elf \
  -kernel uboot.elf \
  -device virtio-net-device,netdev=usernet \
  -audiodev none,id=snd0 \
  -device virtio-vga \
  -object rng-random,filename=/dev/urandom,id=rng0 \
  -device virtio-rng-device,rng=rng0 \
  -device virtio-blk-device,drive=hd0 \
  -netdev user,id=usernet,hostfwd=tcp::"$ssh_port"-:22 \
  -drive file="$drive",format=raw,if=none,id=hd0 \
  -device qemu-xhci -usb -device usb-kbd -device usb-tablet -device usb-audio,audiodev=snd0 \
  -append 'root=/dev/vda1 rw console=ttyS0 swiotlb=1 loglevel=3 systemd.default_timeout_start_sec=600 selinux=0 highres=off mem="$memory_append"M earlycon' \
  -vnc :"$((vnc_port-5900))" \
  "

echo -e "\033[37mStarting VM... \033[0m"
echo -e "\033[37mUsing the following configuration: \033[0m"
echo ""
echo -e "\033[37mvCPU Cores:      \033[0m \033[34m"$vcpu"\033[0m"
echo -e "\033[37mMemory:          \033[0m \033[34m"$memory"\033[0m"
echo -e "\033[37mDisk Path:       \033[0m \033[34m"$drive"\033[0m"
echo -e "\033[37mSSH Port:        \033[0m \033[34m"$ssh_port"\033[0m"
echo -e "\033[37mVNC Port:        \033[0m \033[34m"$vnc_port"\033[0m"
echo ""
echo -e "\033[37mUse the following command to connect SSH server:\0\033[0m\033[34m ssh root@localhost -p "$ssh_port"\033[0m"
echo -e "\033[37mUse the following address to connect VNC server:\0\033[0m\033[34m localhost:"$vnc_port"\033[0m"
echo ""
echo -e "\033[37mUsing the following command to start VM: \033[0m"
echo ""
echo $cmd
echo ""
eval $cmd
