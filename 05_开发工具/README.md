# 开发工具索引

## 已下载

| 文件 | 来源/用途 |
|---|---|
| `DriverAssitant_v5.11.zip` | Rockchip USB 驱动，版本与泰山派文档一致 |
| `RKDevTool_Release_v2.96_zh.zip` | Windows 烧录工具；文档原版本为 2.92，此处使用可公开直连的较新 2.96 中文版 |
| `SDDiskTool_cn_v1.74.zip` | TF 卡制作工具；文档原版本为 1.7/1.69，此处使用较新 1.74 中文版 |
| `platform-tools_r33.0.3-windows.zip` | Google 官方 ADB/Fastboot Windows 版 |
| `platform-tools_r33.0.3-linux.zip` | Google 官方 ADB/Fastboot Linux 版 |
| `scrcpy-win64-v2.3.1.zip` | Genymobile 官方 Scrcpy 2.3.1 |
| `rkdeveloptool/` | Rockchip 官方开源 Linux/macOS RockUSB 烧录工具源码 |

## 使用建议

Windows 烧录顺序：

1. 解压并安装 `DriverAssitant_v5.11.zip`。
2. 使用带数据功能的 Type-C 线连接开发板。
3. 让开发板进入 Loader 或 Maskrom 模式。
4. 使用 RKDevTool 烧录镜像。

Linux 可编译 `rkdeveloptool`：

```bash
sudo apt install libudev-dev libusb-1.0-0-dev dh-autoreconf pkg-config
cd rkdeveloptool
autoreconf -i
./configure
make
```

工具压缩包均保持原包，不自动运行任何 EXE。
