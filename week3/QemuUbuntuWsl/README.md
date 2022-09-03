
<h1 align="center">
  <img src="https://assets.ubuntu.com/v1/29985a98-ubuntu-logo32.png" width="200">
  <br>Ubuntu<br>
</h1>

---

# 在 WSL 通过 QEMU 仿真 RISC-V 环境并启动 Ubuntu RISC-V 系统

> 修订日期 2022-09-02

## 安装必要环境

### 安装 WSL

推荐使用 `Ubuntu 22.04.1 LTS` 。可单击 [此处](https://docs.microsoft.com/zh-cn/windows/wsl/install) 参阅官方文献。

### 安装 VNC Viewer

单击 [此处](https://www.realvnc.com/en/connect/download/viewer/) 前往下载地址。如果速度较慢请考虑科学上网。该软件只有英文，请勿惊慌。

## 安装支持 RISC-V 架构的 QEMU 模拟器

### 使用发行版提供的预编译软件包，这里以 Ubuntu 为例。

```bash
sudo apt install qemu-system-riscv
qemu-system-riscv64 --version
QEMU emulator version 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.3)
Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers
```

## 下载 Ubuntu 22.04.1 RISC-V 系统镜像

预安装的 Ubuntu 镜像：https://cdimage.ubuntu.com/releases/22.04.1/release/

另外，需要从本仓库下载 `uboot.elf` 和 `fw_jump.elf` 。

## 启动 Ubuntu RISC-V 虚拟机

### 命令行虚拟机

- 确认当前目录内包含 `fw_jump.elf`， `uboot.elf`，`ubuntu-22.04.1-preinstalled-server-riscv64+unmatched.img.xz` 和 `start_ubuntu.sh`
- 解压镜像压缩包 `xz -dk ubuntu-22.04.1-preinstalled-server-riscv64+unmatched.img.xz` 或使用解压工具解压。
- 执行启动脚本 `bash start_ubuntu.sh`

### 图形化虚拟机


- 确认当前目录内包含 `fw_jump.elf`， `uboot.elf` 和 `ubuntu-22.04.1-preinstalled-server-riscv64+unmatched.img.xz`
- 下载教程目录下的 `start_ubuntu_gui_neo.sh` 并放置在同目录下，并视情况调整设置
- 解压镜像压缩包 `xz -dk ubuntu-22.04.1-preinstalled-server-riscv64+unmatched.img.xz` 或使用解压工具解压
- 执行启动脚本 `bash start_ubuntu_gui_neo.sh`
- 根据脚本提示信息连接虚拟机的 SSH Server
- 启动 VNC Viewer ，在地址栏内输入脚本信息回显的地址按回车连接。如果提示未加密请忽略。

### [可选] 启动参数调整

- `vcpu` 为 qemu 运行线程数，与 CPU 核数没有严格对应，建议维持为 8 不变
- `memory` 为虚拟机内存数目，可随需要调整
- `drive` 为虚拟磁盘路径，可随需要调整
- `ssh_port` 为转发的 SSH 端口，默认为 12055，可随需要调整。
- `vnc_port` 为转发的 VNC 端口，默认为 12056，可随需要调整。

## 登录虚拟机

> 默认的用户名和密码均为 `ubuntu` ，第一次登录时，系统会要求修改密码。
>
> 在 console 直接登录可能出现输入异常

- 用户名: `ubuntu`
- 默认密码: `ubuntu`

- 登录方式: 命令行 `ssh -p 12055 ubuntu@localhost` (或使用您偏好的 ssh 客户端)

登录成功之后，可以看到如下的信息：

```bash
Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-1016-generic riscv64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Sep  3 20:18:53 UTC 2022

  System load:           1.7119140625
  Usage of /:            87.6% of 4.18GB
  Memory usage:          3%
  Swap usage:            0%
  Processes:             167
  Users logged in:       0
  IPv4 address for eth0: 10.0.2.15
  IPv6 address for eth0: fec0::5054:ff:fe12:3456

  => / is using 87.6% of 4.18GB

 * Super-optimized for small spaces - read how we shrank the memory
   footprint of MicroK8s to make it the smallest full K8s around.

   https://ubuntu.com/blog/microk8s-memory-optimisation

30 updates can be applied immediately.
13 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable


Last login: Sat Sep  3 15:03:29 2022
ubuntu@ubuntu:~$
```

## 参考文献

- [通过 QEMU 仿真 RISC-V 环境并启动 OpenEuler RISC-V 系统](https://github.com/openeuler-mirror/RISC-V/blob/master/doc/tutorials/vm-qemu-oErv.md)
- [在 WSL 通过 QEMU 仿真 RISC-V 环境并启动 OpenEuler RISC-V 系统](https://github.com/ArielHeleneto/Work-PLCT/blob/master/qemuOnWSL/ReadMe.md)
