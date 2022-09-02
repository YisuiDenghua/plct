---
title: 笔记：Ubuntu RISC-V
categories: 
  - Ubuntu
  - RISC-V
  - 教程
#pic: https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/NixOS_logo.svg/1280px-NixOS_logo.svg.png
author: 
 - 一穂灯花
 - Ubuntu Community
date: 2022-09-03 23:00:00
tags: 
 - Ubuntu
 - RISC-V
 - Linux
---

<h1 align="center">
  <img src="https://assets.ubuntu.com/v1/29985a98-ubuntu-logo32.png" width="200">
  <br>Ubuntu<br>
</h1>


# RISC-V

从 Ubuntu 20.04 LTS 开始，Ubuntu 为 RISC-V 平台提供 riscv64 架构版本。

## 镜像

### 下载预安装的 Server 镜像

https://cdimage.ubuntu.com/releases/22.04.1/release/

https://cdimage.ubuntu.com/releases/20.04.4/release/

## 论坛

可在 [Ubuntu Server 论坛（英文）](https://discourse.ubuntu.com/c/server/17) 讨论 RISC-V 平台的 Ubuntu。

## 使用 QEMU 启动 RISC-V 版本的 Ubuntu

> 警告：本文所介绍的内容适用于 Ubuntu，不适用于其他发行版。

预先准备：

```bash
apt install qemu-system-misc opensbi u-boot-qemu qemu-utils
```

**要启动 Ubuntu 22.04.1（Jammy）或更新版本的镜像，需从 Ubuntu 22.04 或更新版本的 Ubuntu 宿主机使用 u-boot-qemu 。**

在安装这些软件后，可使用 [HiFive](https://wiki.ubuntu.com/HiFive) 的预安装镜像来启动虚拟机。

首先，解压镜像：

```bash
xz -dk ubuntu-22.04.1-preinstalled-server-riscv64+unmatched.img.xz
```

> 提示：如果想要一个稍大的磁盘，可以扩充磁盘（文件系统会同时自动地被调整大小）。
> 
> ```bash
> qemu-img resize -f raw ubuntu-22.04.1-preinstalled-server-riscv64+unmatched.img +5G
> ```

接下来，使用 OpenSBI 引导器及 u-boot-qemu 来启动虚拟机。一个可行的命令示例如下：

```bash
qemu-system-riscv64 \
-machine virt -nographic -m 2048 -smp 4 \
-bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
-kernel /usr/lib/u-boot/qemu-riscv64_smode/uboot.elf \
-device virtio-net-device,netdev=eth0 -netdev user,id=eth0 \
-drive file=ubuntu-22.04.1-preinstalled-server-riscv64+unmatched.img,format=raw,if=virtio
```

其中较为重要的选项是：

1. 使用 `-machine virt` 选择 QEMU 的通用虚拟平台
2. QEMU 启动的第一阶段的固件是 OpenSBI：`-bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf`
3. 第二阶段固件 U-Boot 通过 ` -kernel /usr/lib/u-boot/qemu-riscv64_smode/uboot.elf` 被载入内存

> 提示：可按需使用直通网络、调整内存（ `-m` ） 和 CPU（ `-smp` ）。

切换到串口控制台，等待云初始化（cloud-init）完成，然后使用 `ubuntu:ubuntu` 登录。

在启动之后，会出现如下的信息：

```
...
U-Boot menu
1:       Ubuntu 22.04.1 LTS 5.15.0-1016-generic
2:       Ubuntu 22.04.1 LTS 5.15.0-1016-generic (rescue target)
Enter choice: 

```

通常情况下，选择 1 即可。

第一次使用 `ubuntu:ubuntu` 登录时，系统会要求用户修改密码。

```
...
[  OK  ] Reached target Cloud-init target.

ubuntu login: ubuntu
Passwd:
You are requered to change your password immediately (administrator enforced).
Current password:
New password:
Retype new password
...
```

此时，需输入当前密码，回车。随后设置新密码，并验证。


---

参考：https://wiki.ubuntu.com/RISC-V
