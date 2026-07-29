# 第 6 课实验：C 用户态程序与交叉编译

> 更新日期：2026-07-29
> 当前状态：开发主机与通用 AArch64 交叉工具链已就绪；`hello.c` 尚未创建。

本目录保存第 6 课的最小源码、编译命令和验证记录。

## 当前开发链路

```text
Windows 主机
  → VMware Workstation Pro
    → Ubuntu 22.04.5 LTS x86_64
      → aarch64-linux-gnu-gcc 11.4.0
        → hello-rk3566（AArch64 Linux ELF，静态链接）
          → SSH / SCP
            → 泰山派 RK3566 Buildroot（AArch64）
```

已确认 Ubuntu 可以通过以下命令登录开发板：

```bash
ssh root@192.168.30.227
```

## 已完成的准备

- Ubuntu 22.04.5 LTS 已安装、更新并重启；
- 桥接网络正常，Ubuntu 与泰山派处于 `192.168.30.0/24`；
- `open-vm-tools` 和 `open-vm-tools-desktop` 已确认；
- `aarch64-linux-gnu-gcc 11.4.0` 已验证；
- 已安装 `file`、AArch64 binutils、GDB、多数内核/设备树构建依赖；
- 已建立 VMware 快照 `02-Ubuntu2204-CrossTools-Ready`。

## 文件约定

后续实际源码放在 Ubuntu 自身的 Linux 文件系统：

```text
~/workspace/rk3566/user-apps/hello/
```

不要把 Linux SDK、内核源码或本实验的构建目录直接放在 Windows NTFS 共享目录中编译。

计划创建：

- `hello.c`：最小 C 用户态程序；
- `hello-rk3566`：使用静态链接产生的 ARM64 ELF；
- `build.log` 或学习记录：保存实际编译命令和检查结果。

## 首次编译策略

第一阶段优先使用 `-static`：把需要的 C 运行库代码一并链接进 `hello-rk3566`，先避开 Ubuntu glibc 与开发板 Buildroot 动态加载器、`libc.so` 版本不匹配的问题。

这只是入门验证策略；后续依赖目标系统库或进行真实项目构建时，必须改用与目标 Buildroot / SDK 匹配的交叉工具链和 sysroot。

## 下一步实验

1. 创建 `~/workspace/rk3566/user-apps/hello`；
2. 编写最小 `hello.c`；
3. 用 `aarch64-linux-gnu-gcc -static` 编译；
4. 用 `file`、`readelf` 分析 AArch64 ELF；
5. 用 `scp` 上传到开发板 `/userdata`；
6. 在板端运行并用 `echo $?` 检查退出码。
