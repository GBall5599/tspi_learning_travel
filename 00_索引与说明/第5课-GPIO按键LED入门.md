# 第 5 课：GPIO、按键与 LED 入门

> 完成日期：2026-07-26  
> 系统：Buildroot 2024.02 + Linux 6.1.141  
> 运行入口：SSH `root@192.168.1.8`

## 1. 本课目标

从 Linux 设备文件基础进入硬件观察与最小控制：

```text
设备文件与设备号
  → gpiochip、GPIO 组和 line offset
  → 新旧 GPIO 接口盘点
  → Linux LED 子系统
  → RGB LED 最小亮灭实验
  → Linux input 子系统
  → REC 按键事件验证
  → 恢复原状态
```

## 2. 设备文件基础

Linux 使用 `/dev` 下的设备节点作为用户程序访问内核驱动的入口。设备文件不是保存普通文本内容的普通文件。

以 `/dev/gpiochip3` 为例：

```text
crw------- 1 root root 254, 3 ... /dev/gpiochip3
```

含义：

- `c`：字符设备；
- `rw-------`：只有 root 可读写；
- `254`：主设备号，用于定位已注册的字符设备处理程序；
- `3`：次设备号，用于区分同类设备的不同实例。

本次验证：

```sh
ls -l /sys/dev/char/254:3
```

结果指向：

```text
../../devices/platform/pinctrl/fe760000.gpio/gpiochip3
```

证明 `/dev/gpiochip3` 的设备号 `254,3` 已关联到内核中的 GPIO3 设备。

## 3. GPIO 名称和编号

RK3566 每个 GPIO bank 通常有 32 条 line：

| 分组 | line offset |
|---|---:|
| A0～A7 | 0～7 |
| B0～B7 | 8～15 |
| C0～C7 | 16～23 |
| D0～D7 | 24～31 |

示例：

```text
GPIO3_C2 → gpiochip3，line offset 18
GPIO4_D5 → gpiochip4，line offset 29
```

40Pin 的物理 Pin 编号只表示外部连接器上的位置，不能直接当作 line offset。必须按以下关系转换：

```text
物理 Pin 编号 → 原理图中的 GPIO 名称 → gpiochip + line offset
```

例如本地 IO 表中的物理 Pin 16 对应 `GPIO3_A4`，其 line offset 是 4，而不是 16。

## 4. GPIO 接口盘点

系统存在五个新版 GPIO 字符设备：

```text
/dev/gpiochip0
/dev/gpiochip1
/dev/gpiochip2
/dev/gpiochip3
/dev/gpiochip4
```

常用 libgpiod 工具均未找到，退出码为 1：

```text
gpiodetect：未找到
gpioinfo：未找到
gpioget：未找到
gpioset：未找到
```

这表示内核字符设备接口存在，但当前 Buildroot 根文件系统没有提供常用 libgpiod 命令行工具。

旧版 sysfs 接口存在：

```text
/sys/class/gpio/export
/sys/class/gpio/unexport
/sys/class/gpio/gpiochip0
/sys/class/gpio/gpiochip32
/sys/class/gpio/gpiochip64
/sys/class/gpio/gpiochip96
/sys/class/gpio/gpiochip128
```

GPIO3 实测：

```text
base  = 96
ngpio = 32
label = gpio3
```

所以 GPIO3 的旧版 sysfs 全局编号范围为 96～127：

```text
全局 GPIO 编号 = base + line offset
```

例如：

```text
GPIO3_C2 → 96 + 18 = 114
GPIO4_D5 → 128 + 29 = 157
```

本课没有随机向 `/sys/class/gpio/export` 写入未知编号。

## 5. Linux LED 子系统

系统提供：

```text
/sys/class/leds/mmc0::
/sys/class/leds/rgb-led-r
/sys/class/leds/rgb-led-g
/sys/class/leds/rgb-led-b
```

其中 `mmc0::` 与存储设备活动有关，本课未操作。选择内核已经明确管理的 `rgb-led-r` 完成安全实验。

红色通道初始状态：

```text
max_brightness = 1
trigger        = timer
delay_on       = 500 ms
delay_off      = 500 ms
brightness     = 0/1 自动变化
```

这表示红灯每次亮 500 ms、灭 500 ms，完整周期 1 秒，频率约 1 Hz，占空比 50%。

## 6. RGB 红色通道最小实验

停止自动触发器：

```sh
echo none > /sys/class/leds/rgb-led-r/trigger
```

确认：

```text
[none]
brightness = 0
```

手动点亮：

```sh
echo 1 > /sys/class/leds/rgb-led-r/brightness
```

结果：

```text
brightness = 1
```

肉眼观察到红色持续参与混色，出现白、紫、红、黄等颜色：

```text
R=1 G=1 B=1 → 白
R=1 G=0 B=1 → 紫
R=1 G=0 B=0 → 红
R=1 G=1 B=0 → 黄
```

手动熄灭：

```sh
echo 0 > /sys/class/leds/rgb-led-r/brightness
```

结果：

```text
brightness = 0
```

一次误将 `brightness` 拼成 `brightnes`，sysfs 拒绝创建不存在的属性并返回 `Permission denied`。这说明即使是 root，也不能在内核管理的 sysfs 中随意创建属性文件。

## 7. 恢复 LED 原状态

恢复定时器：

```sh
echo timer > /sys/class/leds/rgb-led-r/trigger
```

恢复后核对：

```text
trigger    = timer
delay_on   = 500 ms
delay_off  = 500 ms
```

肉眼确认 RGB 闪烁现象恢复。

## 8. Linux input 输入设备

系统存在：

```text
/dev/input/event0～event5
```

它们均为主设备号 13 的字符设备，次设备号为 64～69。

通过 `/proc/bus/input/devices` 确认：

| 事件节点 | 名称 | 来源 |
|---|---|---|
| `event0` | `hdmi_cec_key` | HDMI CEC 按键 |
| `event1` | `fe700030.pwm` | 红外遥控接收器 |
| `event2` | `rk805 pwrkey` | PMIC 电源键 |
| `event3` | `bt-powerkey` | 蓝牙相关电源键事件 |
| `event4` | `adc-keys` | REC ADC 按键 |
| `event5` | `rk-headset` | 耳机按键 |

本地资料说明：

- PWR 是电源按键；
- RST 是硬件复位按键；
- REC 接入 `SARADC_VIN0`，由 `adc-keys` 驱动上报；
- 按住 REC 再按 RST 可能进入 Loader，因此实验中只单独短按 REC。

## 9. REC 按键事件实验

系统存在：

```text
/usr/bin/evtest
```

执行：

```sh
evtest /dev/input/event4
```

识别结果：

```text
Input device name: "adc-keys"
Event type 1 (EV_KEY)
Event code 408 (KEY_RESTART)
```

短按一次 REC 的结果：

```text
value 1 → 按键按下
value 0 → 按键释放
SYN_REPORT → 一组输入事件结束
```

按下时间为 `1785074362.366297`，释放时间为 `1785074362.574324`，相差约 208 ms。事件时间对应 2026-07-26 21:59:22（Asia/Shanghai）。

## 10. 本课结论

```text
设备文件和设备号：✅ 理解
GPIO 字符设备：✅ 发现 gpiochip0～4
旧版 GPIO sysfs：✅ 验证 base/ngpio/label
GPIO 编号换算：✅ 掌握 bank、组、offset、全局编号
libgpiod 工具：❌ 当前镜像未安装
RGB LED：✅ 手动亮灭并恢复 timer 500/500
Linux input：✅ 完成 event0～5 映射
REC 按键：✅ 捕获 KEY_RESTART 按下/释放事件
安全恢复：✅ 完成
```

## 11. 下一课

第 6 课：第一个 C 用户态程序与 AArch64 交叉编译。
