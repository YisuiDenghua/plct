#!/bin/bash

# The script is created for starting a riscv64 qemu virtual machine with specific parameters on WSL on Windows 10

## Configuration
vcpu=8
memory=8
ssh_port=12055
vnc_port=12056
drive="ubuntu-22.04.1-preinstalled-server-riscv64+unmatched.img"

cmd="qemu-system-riscv64 \
  -machine virt -nographic -m "$memory"G -smp "$vcpu" \
  -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
  -kernel /usr/lib/u-boot/qemu-riscv64_smode/uboot.elf \
  -device virtio-net-device,netdev=usernet \
  -device virtio-vga \
  -netdev user,id=usernet,hostfwd=tcp::"$ssh_port"-:22 \
  -drive file="$drive",format=raw,if=virtio \
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
