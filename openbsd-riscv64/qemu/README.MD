# 通过 QEMU 仿真 RISC-V 环境并启动 OpenBSD/riscv64系统

> 修订日期 2022-09-30

<h1 align="center">
  <img src="https://raw.githubusercontent.com/YisuiDenghua/plct/main/openbsd-riscv64/qemu/spl.png" width="200">
  <br>OpenBSD<br>
</h1>

## 安装必要环境



### 安装 QEMU

如果你使用 Windows，可不必安装 WSL。从 https://qemu.weilnetz.de/w64/ 可下载到 64 位的 QEMU。其默认安装路径是 `C:\Program Files\qemu`。在安装完成后，需将安装路径添加到系统的 PATH 环境变量当中。详见 [微软官方文档](https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/path#remarks) 。

如果你使用 macOS，Linux 或者 BSD 等类 Unix 系统，可使用系统所提供的包管理器安装 QEMU。

完成之后，可从下列两个选项中任选其一，安装 OpenBSD/riscv64。



## 下载 OpenBSD/riscv64 预安装系统镜像

> 提示：本预安装镜像是 OpenBSD 7.2 的快照版本，当前最新的稳定版本是 OpenBSD 7.1。

 https://cowtransfer.com/s/742433dcf3a743 点击链接查看 [ bsd.img.tar.xz ] ，或访问奶牛快传 cowtransfer.com 输入传输口令 ilf53q 查看；

另外，需要从本仓库下载 `uboot.elf` 和 `fw_jump.elf` 。

## 启动 OpenBSD/riscv64 虚拟机

### 命令行虚拟机

- 确认当前目录内包含 `fw_jump.elf`， `uboot.elf` 和`bsd.img.tar.xz` 。
- 解压镜像压缩包 `bsd.img.tar.xz` 。
- 如果你使用的是 Windows，需从本仓库中下载 `startbsd.bat` 并在 Windows PowerShell 中使用 `cd` 命令进入当前目录，并执行启动脚本 `./startbsd.bat`。
- 如果你使用的是类 Unix 系统，需从本仓库中下载 `startbsd.sh` 并在终端中使用 `cd` 命令进入当前目录，并执行启动脚本 `./startbsd.sh`。若提示权限不足，则需先用 `chmod +x startbsd.sh` 来为脚本赋予执行权限。

### 图形化虚拟机

> 提示：本脚本将会使用 QEMU 的原生 GTK 前端输出 GUI，不需要使用 VNC。由于默认安装的 wsl 不支持 GUI，Windows 用户可使用 bat 的启动脚本来运行 Windows 版本的 QEMU。

- 确认当前目录内包含 `fw_jump.elf`， `uboot.elf` 和`bsd.img.tar.xz` 。
- 解压镜像压缩包 `bsd.img.tar.xz` 。
- 如果你使用的是 Windows，需从本仓库中下载 `startbsd_gui_neo.bat` 并在 Windows PowerShell 中使用 `cd` 命令进入当前目录，并执行启动脚本 `./startbsd_gui_neo.bat`。
- 如果你使用的是类 Unix 系统，需从本仓库中下载 `startbsd_gui_neo.sh` 并在终端中使用 `cd` 命令进入当前目录，并执行启动脚本 `./startbsd_gui_neo.sh`。若提示权限不足，则需先用 `chmod +x startbsd_gui_neo.sh` 来为脚本赋予执行权限。


## 登录虚拟机

> 警告：默认密码是弱口令。为了安全，建议在安装之后使用 `passwd` 修改密码。

- 用户名: `openbsd`
- 默认密码: `OpenBSD233@##`
- 默认 ROOT 密码：`OpenBSD233@##`

登录成功之后，可以看到如下的信息：

```
Last login: Fri Sep 30 18:34:29 on console
OpenBSD 7.2 (GENERIC.MP) #188: Wed Sep 28 04:06:11 MDT 2022

Welcome to OpenBSD: The proactively secure Unix-like operating system.

Please use the sendbug(1) utility to report bugs in the system.
Before reporting a bug, please try to reproduce it with the latest
version of the code.  With bug reports, please try to ensure that
enough information to reproduce the problem is enclosed, and if a
known fix for it exists, include that as well.

You have new mail.
obrv$
```
