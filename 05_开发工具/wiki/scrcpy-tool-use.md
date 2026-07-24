<!--
source: https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use.html
retrieved_at: 2026-07-19 15:14:10 +08:00
category: tool
-->
[Skip to content](https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use.html#VPContent)

页面导航

# 【立创·泰山派RK3566开发板】Scrcpy同屏工具使用手册 [​](https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use.html\#%E3%80%90%E7%AB%8B%E5%88%9B%C2%B7%E6%B3%B0%E5%B1%B1%E6%B4%BErk3566%E5%BC%80%E5%8F%91%E6%9D%BF%E3%80%91scrcpy%E5%90%8C%E5%B1%8F%E5%B7%A5%E5%85%B7%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C)

![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_192302.png)

![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_192305.png)

![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_192309.png)

![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_192312.png)

## 文档更新说明 [​](https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use.html\#%E6%96%87%E6%A1%A3%E6%9B%B4%E6%96%B0%E8%AF%B4%E6%98%8E)

![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_192348.png)

## 免责声明 [​](https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use.html\#%E5%85%8D%E8%B4%A3%E5%A3%B0%E6%98%8E)

本文档虽力求准确，但可能存在错误或遗漏，用户需谨慎评估适用性；我们保留随时修订的权利，且不保证旧版本内容的有效性，为了得到最新版本的产品信息，请定时访问立创开发板官网进行资料的更新下载。本文档版权及最终解释权归深圳嘉立创科技集团股份有限公司所有。请务必注意以上声明，自行评估风险并决策，我们对使用本文档产生的任何问题概不负责。感谢您的包容与支持。

**准备工作**

- 需要一台win10电脑，其他系统理论上也可以但是我没测试，我这里以我电脑为例，后续所有的环境以及开发编译如果不做特殊说明默认都是基于此配置电脑进行!!

![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_192437.png)

- 注意：泰山派需烧录Android系统固件，Linux不支持scrcpy

- scrcpy安装包： [https://github.com/Genymobile/scrcpy/releases](https://github.com/Genymobile/scrcpy/releases)


## 简介 [​](https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use.html\#%E7%AE%80%E4%BB%8B)

### 为什么要用scrcpy [​](https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use.html\#%E4%B8%BA%E4%BB%80%E4%B9%88%E8%A6%81%E7%94%A8scrcpy)

- 在泰山派没有接显示屏、触摸、鼠标、键盘等情况下，可以通过scrcpy投屏到电脑进行人机交互。

- scrcpy安装非常简单，在win10系统中下载点击运行就能使用。

- 连接非常简单，只需要typec数据线连到泰山派开发板。

- 画面流畅度和质量也很高。

- 最主要的是它是开源的 [https://github.com/Genymobile/scrcpy](https://github.com/Genymobile/scrcpy)。


### 什么是scrcpy [​](https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use.html\#%E4%BB%80%E4%B9%88%E6%98%AFscrcpy)

scrcpy是一个用于镜像连接Android设备并通过USB或TCP/IP进行控制的应用程序。它可以将Android设备的视频和音频镜像到计算机，并允许使用计算机的键盘和鼠标来控制设备。scrcpy无需获取root访问权限，并且适用于Linux、Windows和macOS操作系统。 scrcpy的特点包括：

- 轻量级：原生应用，仅显示设备屏幕内容。

- 高性能：帧率在30到120之间，取决于设备性能。

- 高质量：支持1920×1080或更高分辨率。

- 低延迟：延迟约为35～70毫秒。

- 快速启动：显示第一帧画面只需约1秒钟。

- 非入侵性：在Android设备上不需要安装任何软件。

- 用户友好：无需帐号、无广告、无需互联网。

- 自由：免费且开源。


**scrcpy的功能包括：**

- 音频转发（仅适用于Android 11及以上版本）。

- 录制屏幕。

- 在设备屏幕关闭时进行镜像。

- 双向剪贴板复制粘贴。

- 可配置的画质设置。

- 相机镜像（仅适用于Android 12及以上版本）。

- 作为摄像头的镜像（V4L2）（仅适用于Linux）。

- 模拟物理键盘/鼠标（HID）。

- 支持OTG模式等等。


**所需前提条件：**

- Android设备至少需要API 21（Android 5.0）。

- 音频转发要求API >= 30（Android 11及以上版本）。

- 确保已在设备上启用了USB调试。

- 在某些设备上，还需要启用其他选项"USB调试（安全设置）"（与USB调试不同）才能使用键盘和鼠标进行控制。设置此选项后，需要重新启动设备。

- 注意，使用OTG模式运行scrcpy时不需要USB调试。


### 下载scrcpy [​](https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use.html\#%E4%B8%8B%E8%BD%BDscrcpy)

你可以在scrcpy的GitHub页面 [https://github.com/Genymobile/scrcpy](https://github.com/Genymobile/scrcpy) 上找到最新的发行版本和下载适合自己电脑的版本。我这里只提供win64版本的，它支持linux mac需要其他的大家自己去git厂库。

【scrcpy-win64-v2.3.1.zip】下载

📌 [下载中心（点击跳转）](https://wiki.lckfb.com/zh-hans/tspi-rk3566/download-center.html)

📌 在 `下载中心`->`百度网盘`->`第07章.【立创·泰山派】开发工具`->`scrcpy-win64-v2.3.1.zip压缩包`中。

- 下载完成后解压目录如下：

![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_193213.png)

### 连接泰山派 [​](https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use.html\#%E8%BF%9E%E6%8E%A5%E6%B3%B0%E5%B1%B1%E6%B4%BE)

将泰山派通过USB数据线连接到电脑，并保证进入android。

- 确保你的电脑供电充足，有些电脑usb供电能力步骤会导致泰山派无法进入系统，如果无法保证可通过PD诱骗电源小板进行补电。

- 确保USB调试选项已经打开，泰山派的Android固件都是默认打开ADB调试功能的，判断是否打开可以通过电脑是否有枚举ADB设备来判断。

- 使用带数据功能的数据线，不要用只有充电功能的。


![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_193241.png)

### 启动scrcpy [​](https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use.html\#%E5%90%AF%E5%8A%A8scrcpy)

找到刚解压出来的文件，双击scrcpy.exe启动scrcpy

![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_193302.png)

运行成功显示两个界面分别是命令，和泰山派镜像页面

- 命令行页面

![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_193321.png)

**信息说明：**

shell

```

INFO: ADB device found:
# 找到adb设备，如果开发板没有进入系统等异常这里会失败

INFO:     -->   (usb)      ea16b3d63aceed1a            device  rk3566_tspi
# 泰山派的设备的信息：
# 'usb' 表示设备通过 USB 连接。
# 'ea16b3d63aceed1a' 是设备的序列号。
# 'rk3566_tspi' 泰山派android系统里的名称。

C:\Users\jlc\Desktop\scrcpy-win64-v2.3.1\scrcpy-server: 1 file pushed, 0 skipped. 66.0 MB/s (66007 bytes in 0.001s)
# adb把 scrcpy 服务器文件已经被推送到 Android 设备上，不理解的看adb部分
# 文件推送的速度是 66.0 MB/s
# 文件大小为 66007 字节，推送时间约 0.001 秒。

[server] INFO: Device: [rockchip] rockchip rk3566_tspi (Android 11)
# 这是 scrcpy 服务器提供的设备信息：
# 设备名为 rk3566_tspi。
# 运行的 Android 版本是 Android 11。

INFO: Renderer: direct3d
# 显示渲染器使用的是 Direct3D （Direct3D 是 Windows 中处理 3D 图形的一部分。

INFO: Texture: 1080x1920
# 表示展示在你电脑上的 Android 设备屏幕的尺寸为1080x1920
```

1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

22

23

24

25

26

- 屏幕界面

![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_193411.png)

- 常用快捷键

![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_193437.png)

- 到这里你就可以随心所欲的通过电脑玩转泰山派android系统了

![](../../assets/wiki.lckfb.com/storage/images/zh-hans/tspi-rk3566/tool-use/scrcpy-tool-use/scrcpy-tool-use_20240829_193506.gif)














