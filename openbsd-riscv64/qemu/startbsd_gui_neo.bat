:: The script is created for starting a riscv64 qemu virtual machine with specific parameters on Windows
:: Before running this script, you should install QEMU and add C:\Windows\qemu to your PATH first

qemu-system-riscv64 ^
                -machine virt ^
                -m 2048M ^
                -smp 2 ^
                -bios fw_jump.elf ^
                -kernel uboot.elf ^
                -drive file=bsd.img,format=raw,id=hd0 -device virtio-blk-device,drive=hd0 ^
                -netdev user,id=net0,ipv6=off -device virtio-net-device,netdev=net0 ^
                -device AC97^
                -device qemu-xhci -usb -device usb-kbd -device usb-tablet^
                -device virtio-vga^