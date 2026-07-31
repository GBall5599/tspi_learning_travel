# Linux 驱动长期学习总计划

> 制定日期：2026-07-31
> 适用平台：LCKFB 泰山派 1M RK3566（2G+16G）
> 主内核与 SDK：官方 kernel 6.1 SDK
> 当前起点：第 7 课已完成，下一课为第 8 课显示链路只读盘点
> 总目标：吃透 Linux 驱动核心机制；各子系统先建立框架认识，后续按项目需要深入

---

## 1. 最终能力目标

完成本计划后，应具备以下能力：

```text
从干净 SDK 完成 Buildroot、kernel、DTB 和模块构建
从空目录编写字符设备和 platform 驱动
理解 bus / device / driver / class 与 sysfs
使用设备树描述 GPIO、IRQ、I2C、SPI、PWM、时钟、复位和电源
正确处理进程上下文、中断上下文、并发和延后执行
编写或移植一个 I2C / SPI 客户端驱动
接入 input、LED、backlight、IIO 等标准子系统
使用 dmesg、dynamic debug、debugfs、ftrace 和调用栈定位问题
阅读、修改和移植厂商驱动及旧版本补丁
看懂、编译并修改当前 RK3566 的 U-Boot 和启动配置
完成 D310T9362V1 屏幕、触摸、背光与胖妞智能小手机 Linux 版
```

“掌握”不能只看实验是否运行成功，还必须满足：

```text
能解释
能脱离教程重写
能阅读同类现有驱动
能排查人为制造的故障
能迁移到另一块相似硬件
```

---

## 2. 学习范围与优先级

### 2.1 必须吃透的核心机制

- 内核模块、Kbuild、Kconfig 和内核配置；
- 字符设备及用户态接口；
- Linux 设备模型；
- platform 总线；
- 设备树与驱动匹配；
- GPIO、pinctrl、IRQ；
- 进程上下文、中断上下文；
- mutex、spinlock、atomic、completion、wait queue；
- workqueue、timer、threaded IRQ；
- I2C、SPI 总线驱动模型；
- `probe`、`remove`、deferred probe；
- `devm_*`、引用和资源生命周期；
- 时钟、复位、regulator 的基本使用；
- 驱动日志、调用链、Oops 和跟踪调试；
- 驱动版本移植和真实硬件适配。

### 2.2 建立框架认识并完成代表性实验的子系统

- LED；
- input；
- PWM / backlight；
- IIO；
- UART / TTY；
- DRM / panel / MIPI DSI；
- RTC、NVMEM、MTD 等根据已有模块选择。

第一阶段不要求从零实现 USB、音频、网卡、SDIO、复杂 DRM 控制器或存储控制器；需要时再单独深入。

### 2.3 U-Boot 目标

以当前 RK3566 BSP 的阅读、编译、分析和修改为目标：

- 看懂 BootROM → Loader → U-Boot → kernel / DTB → rootfs → init；
- 看懂并修改板级配置、环境变量、启动命令和 `bootargs`；
- 理解 kernel、DTB、rootfs 和镜像打包关系；
- 能判断启动失败所在阶段；
- 能进行简单启动按键、GPIO、I2C 或 Logo 适配；
- 不要求从零移植到全新 SoC，也不要求重写 DDR 或存储控制器初始化。

---

## 3. 每课课前诊断制度

### 3.1 强制流程

每一节实际课程开始前，必须先进行只针对本课的一问一答：

```text
明确本课边界
→ 一次只问一道题
→ 根据回答动态追问
→ 输出掌握情况
→ 决定本课深度
→ 正式讲解和实操
→ 课后验收
→ 写入学习记录
```

未经课前诊断，不直接开始讲解或执行实验命令。

### 3.2 诊断范围

只检查：

- 本课直接相关概念；
- 本课需要的前置知识；
- 基本代码阅读能力；
- 对实际现象和系统层次的判断。

不检查：

- 后续课程的细节；
- 需要查数据手册才能记住的数值；
- 尚未学过的复杂内核实现；
- 与本课无关的冷门知识。

### 3.3 题量和反馈

- 通常 4～10 题；
- 连续回答准确时提前结束；
- 某个点模糊时增加 1～2 道追问；
- 已确认陌生后停止追加难题；
- 诊断中只做简短标记，不立即展开完整教学；
- 诊断结束后统一给出已掌握、薄弱、误解和本课深度。

### 3.4 深度等级

| 等级 | 判断 | 本课策略 |
|---|---|---|
| A | 能准确解释、应用并举例 | 快速复习，直接进入进阶实操 |
| B | 核心正确，细节或实操不足 | 针对性补齐后进入标准实操 |
| C | 接触过但不系统 | 标准深度讲解并增加小实验 |
| D | 基本陌生或存在关键误解 | 拆成更小课程，详细学习 |

### 3.5 C 语言和用户态处理

不设置冗长的独立 C 语言基础阶段。只在相关驱动课前检查：

```text
指针和二级指针
结构体与函数指针
回调
宏和位运算
链表
内存与对齐
goto 错误回收
Makefile / Kbuild
open / read / write / ioctl / poll / mmap
```

已经掌握就跳过；只有暴露具体缺口时才做针对性补充。

---

## 4. 课程粒度与完成标准

### 4.1 课程粒度

下面的编号是课程组，不代表必须一次学完。大型主题应拆成 `x-1`、`x-2` 等小课，每小课约 1～2 次有效学习会话，并在每小课前单独诊断。

例如 I2C 应拆成：

```text
I2C-1：协议与现有接口观察
I2C-2：adapter / client / driver 模型
I2C-3：设备树匹配与 probe
I2C-4：寄存器访问与 regmap
I2C-5：真实设备适配
```

### 4.2 掌握标记

| 标记 | 标准 |
|---|---|
| 🟡 做过 | 跟随步骤运行成功，但不能独立解释或复现 |
| ✅ 掌握 | 能脱离步骤重写、解释和排查常见错误 |
| ⭐ 吃透 | 能阅读同类驱动并迁移到另一块硬件 |

课程不能因“预计时间到了”自动完成；未通过验收就补实验或重新诊断。

---

## 5. 分阶段路线

### 阶段 0：先跑通小手机硬件基线

#### 第 8 课：当前 Buildroot 显示链路只读盘点

- VOP、HDMI、MIPI DSI、panel；
- framebuffer / DRM；
- backlight；
- touch / input；
- 运行时设备树和内核日志。

全程只读，不改 DTS、不烧录、不操作未知 GPIO。

#### 第 9 课：官方 3.1 寸 MIPI 镜像基线

验证屏幕、背光、触摸、串口、网络和 SSH，建立“硬件可工作”的事实基线。

完成第 9 课后，暂停手机功能堆叠，转入 Linux 底层主线。

---

### 阶段 1：SDK、构建与启动基础

#### 第 10 课：官方 kernel 6.1 SDK 与原始构建

- 在 Ubuntu ext4 中解压 SDK；
- 盘点 `u-boot`、`kernel-6.1`、Buildroot、板级配置和打包目录；
- 完成原始配置构建；
- 保存日志和产物清单；
- 验证原始镜像具有可靠恢复路径。

#### 第 11 课：Kbuild、Kconfig 与单独构建

- `.config`、defconfig、menuconfig；
- 外部模块 Kbuild；
- 单编模块、kernel、DTB；
- 重打包和部署边界；
- C / Makefile 缺口按课前诊断结果补充。

#### 第 12 课：启动流程第一遍

只读分析：

```text
BootROM → Loader → U-Boot → kernel / DTB → rootfs → init
```

建立串口日志、分区和镜像产物的对应关系，暂不修改 U-Boot。

---

### 阶段 2：字符设备与内核接口

#### 第 13 课：最小内核模块

`hello.ko`、模块参数、符号、依赖、加载、卸载、日志和构建错误。

#### 第 14 课：字符设备基础

`alloc_chrdev_region`、`cdev`、`class`、`device`、`file_operations`，完成 `open/read/write/close`。

#### 第 15 课：字符设备进阶

按课前诊断拆分学习：

- `ioctl`；
- 阻塞与非阻塞；
- wait queue；
- `poll`；
- `mmap` 基本机制；
- 用户态统一测试程序。

#### 第 16 课：错误路径与资源生命周期

- `goto` 错误回收；
- `devm_*` 与非 `devm_*`；
- 驱动卸载时仍被打开；
- 重复加载；
- 资源泄漏与引用关系。

---

### 阶段 3：设备模型、platform 与设备树

#### 第 17 课：Linux 设备模型

`bus/device/driver/class`、sysfs、kobject 和引用关系。

#### 第 18 课：platform 总线

无真实硬件的 `platform_device/platform_driver` 实验，再进入设备树创建 platform device。

#### 第 19 课：设备树进阶

- `compatible`、`reg`、`interrupts`；
- `clocks`、`resets`、`regulator`；
- phandle；
- YAML binding 与 `dtbs_check` 基本认识。

#### 第 20 课：第一次受控 DTB 修改

使用 LED 已知属性完成：

```text
DTS/DTSI → DTB → 部署 → 启动 → 运行时验证 → 回退
```

---

### 阶段 4：GPIO、pinctrl、中断与并发

#### 第 21 课：GPIO descriptor 与 LED 驱动

使用现代 `gpiod_*` / `devm_gpiod_*` 接口重做一个 LED platform 驱动。

#### 第 22 课：pinctrl 与 pinmux

理解复用、上下拉、驱动能力、默认状态和睡眠状态。

#### 第 23 课：中断与按键驱动

IRQ 触发类型、线程化中断、中断上下文限制、去抖和 input 基础。

#### 第 24 课：并发与同步

mutex、spinlock、atomic、completion、wait queue；通过人为竞态进行验证。

#### 第 25 课：延后执行

workqueue、delayed work、timer、threaded IRQ；耗时工作不得放在不合适上下文。

---

### 阶段 5：总线与代表性子系统

#### 第 26 课：I2C 驱动模型

从简单寄存器设备开始，再进入 `regmap`、中断和真实设备。

#### 第 27 课：SPI 驱动模型

优先使用 SPI Flash 只读识别实验，再了解 SPI NOR / MTD 框架。

#### 第 28 课：input 子系统

先做 GPIO/input 按键，再分析触摸多点事件。

#### 第 29 课：PWM 与 backlight

区分 SoC PWM、`pwm-backlight` 和 GP7101 等外部背光方案。

#### 第 30 课：IIO 子系统概览

通过已有的 ADC、加速度计、光照或环境传感器选择代表性实验。

#### 第 31 课：UART / TTY 概览

用户态串口、TTY 框架、设备树和控制器驱动调用链；不从零重写 RK3566 UART 控制器。

#### 第 32 课：DRM / panel / MIPI DSI 概览

理解 CRTC、encoder、connector、bridge、panel、显示时序和电源时序；重点做 D310T9362V1 面板适配，不从零实现 VOP/DSI 控制器。

---

### 阶段 6：驱动调试专项

调试应贯穿所有课程，本阶段做系统化复盘：

#### 第 33 课：日志与动态调试

`dev_*` 日志、日志级别、dynamic debug 和 probe 日志。

#### 第 34 课：debugfs 与跟踪

`debugfs`、ftrace、function graph、trace event 和调用链。

#### 第 35 课：Oops 与故障分析

在可恢复环境中分析受控的 NULL pointer、调用栈、符号地址和 `addr2line`。

#### 第 36 课：故障注入考核

人为加入：

- 错误 `compatible`；
- 错误 I2C 地址；
- 错误 IRQ 触发类型；
- 原子上下文睡眠；
- 错误路径资源泄漏；
- input 坐标错误；
- deferred probe 依赖问题。

要求独立定位和修复。

---

### 阶段 7：U-Boot 与 BSP 修改

#### 第 37 课：U-Boot 构建和板级配置

源码结构、defconfig、BoardConfig、单独编译、环境变量和启动命令。

#### 第 38 课：kernel、DTB 与 rootfs 加载链

看懂并修改加载位置、`bootargs`、启动目标和根文件系统选择。

#### 第 39 课：简单板级适配

按需处理启动按键、GPIO、I2C、Logo 或启动顺序；不进入全新 SoC 移植。

---

### 阶段 8：真实硬件适配与毕业项目

#### 第 40 课：D310T9362V1 硬件事实表

确认屏幕、排线、触摸芯片、I2C 地址、背光方式、电源和恢复路径。

#### 第 41 课：旧补丁迁移到当前 kernel 6.1

不盲目 `patch`，逐项比较设备树、Kconfig、Makefile、API 和驱动接口。

#### 第 42 课：触摸、背光和 MIPI 联调

按显示、背光、I2C、IRQ、input 分层调试，不把多个问题混在一起。

#### 第 43 课：胖妞智能小手机 Linux 完整版

自己构建系统、适配硬件、实现状态面板、触摸/按键交互、LED 状态、自启动和日志。

#### 第 44 课：毕业答辩

- 画完整启动链；
- 解释核心驱动模型；
- 现场排查一个故障；
- 从干净 SDK 复现构建；
- 演示真实硬件适配；
- 能说明哪些子系统已吃透、哪些只是了解。

Android 完整版仅作为毕业后的可选进阶。

---

## 6. 外部模块策略

核心前半段优先使用板载 RGB LED、REC 按键、串口和现有屏幕。

后续模块不立即采购，先按 [`外设模块盘点模板.md`](外设模块盘点模板.md) 整理已有模块，再分为：

```text
A：可直接用于课程
B：有用，但需确认电平或接线
C：功能重复，暂不需要
D：当前平台或课程不适合
```

优先候选：

- I2C：AT24Cxx、BH1750、BMP/BME280、MPU6050、DS3231、ADS1115；
- SPI：W25Qxx、SPI OLED、SPI ADC；
- GPIO/IRQ/PWM：LED、按键、无源蜂鸣器、旋转编码器；
- UART：第二个 3.3V USB-TTL、GPS 或其他串口模块；
- 工具：万用表、逻辑分析仪、面包板、杜邦线和限流电阻。

所有模块先确认供电和逻辑电平，禁止把 5V 信号直接接入 RK3566 GPIO。

---

## 7. 每课产物

每节实操课至少留下：

```text
课前诊断结论
本课深度选择
源码
Kconfig / Makefile（适用时）
DTS 修改（适用时）
用户态测试程序
构建和部署命令
正常日志
错误日志或故障实验
恢复方法
课后验收结论
```

项目和驱动源码使用模块化目录，实验产物不与官方 SDK 原始源码混放；必要的补丁、说明和轻量代码同步到 Git，大型 SDK、镜像和构建目录保持本地。