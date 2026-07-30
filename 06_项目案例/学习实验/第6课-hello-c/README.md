# 第 6 课实验：C 用户态程序与交叉编译

> 更新日期：2026-07-30
> 当前状态：✅ 已完成。最小 C 程序已在 Ubuntu 上交叉编译为静态 AArch64 ELF，已上传并在泰山派 RK3566 的 Buildroot 系统成功运行。

本目录保存第 6 课的参考源码和 Windows 备用构建脚本；实际学习过程、编译命令和板端验证结果见：

- [`00_索引与说明/学习记录/2026-07-29-第6课-C用户态程序与交叉编译.md`](../../../00_索引与说明/学习记录/2026-07-29-第6课-C用户态程序与交叉编译.md)
- [`00_索引与说明/第6课-C用户态程序与交叉编译.md`](../../../00_索引与说明/第6课-C用户态程序与交叉编译.md)

## 已完成的开发链路

```text
Windows 主机
  → VMware Workstation Pro
    → Ubuntu 22.04.5 LTS x86_64
      → aarch64-linux-gnu-gcc 11.4.0
        → hello（AArch64 Linux ELF，静态链接）
          → SCP
            → 泰山派 RK3566 Buildroot（AArch64）
              → /userdata/hello_c 成功运行
```

2026-07-29 的网络快照中，Ubuntu 与开发板位于 `192.168.30.0/24` 网段，开发板 IP 为 `192.168.30.227`。该 IP 是当时的 DHCP 结果，后续连接前仍应以串口或路由器状态为准。

## 已完成的环境准备

- Ubuntu 22.04.5 LTS 已安装、更新并重启；
- VMware 桥接网络、`open-vm-tools` 和 `open-vm-tools-desktop` 已确认；
- `aarch64-linux-gnu-gcc 11.4.0` 已验证；
- 已安装 `file`、AArch64 binutils、GDB 和多数内核 / 设备树构建依赖；
- 已建立 VMware 快照 `02-Ubuntu2204-CrossTools-Ready`；
- Linux SDK、内核源码和实际构建目录均应放在 Ubuntu 自身的 ext4 文件系统中，而不是 Windows NTFS 共享目录中。

## 本课实际结果

实际源文件在 Ubuntu 工作目录 `~/workspace/rk3566-lesson6` 中创建，核心内容为：

```c
#include <stdio.h>

int main(void)
{
    printf("hello from RK3566!\\n");
    return 0;
}
```

交叉编译命令：

```bash
aarch64-linux-gnu-gcc -std=c11 -Wall -Wextra -O0 -static -o hello hello.c
```

验证结果：

- 编译无报错、无警告；
- `file hello` 确认为 `ELF 64-bit`、`ARM aarch64`、`statically linked`；
- 在 x86-64 Ubuntu 上直接执行出现 `Exec format error`，符合目标架构不同的预期；
- 使用 `scp hello root@<开发板IP>:/userdata/hello_c` 上传成功；
- 板端运行 `/userdata/hello_c` 输出 `hello from RK3566!`；
- 紧接着 `echo $?` 的结果为 `0`。

## 本目录文件说明

| 文件 | 用途 | 状态 |
|---|---|---|
| `hello.c` | 本课最小 C 程序的仓库参考副本 | ✅ 已存在 |
| `build-rk3566.ps1` | 面向 Windows 独立工具链的备用构建脚本 | ⏳ 未作为本课实际验证链路使用 |
| `README.md` | 本课实验说明与结果索引 | ✅ 已同步 |

> 本课实际验证使用的是 Ubuntu 中的 `aarch64-linux-gnu-gcc 11.4.0`。`build-rk3566.ps1` 依赖 Windows 目录下独立解压的工具链，不能把它与已验证的 Ubuntu 构建结果混为一谈。

## 后续衔接

第 6 课已经完成，当前主线进入第 8 课“显示与 3.1 寸 MIPI 屏”。后续当需要依赖目标系统库、Buildroot SDK、内核模块或设备树编译时，应改用与目标 Buildroot / SDK 匹配的工具链和 sysroot，而不是长期依赖本课的静态链接入门策略。