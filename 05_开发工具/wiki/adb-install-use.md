<!--
source: https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/adb-install-use.html
retrieved_at: 2026-07-19 15:13:27 +08:00
category: tool
-->
[Skip to content](#VPContent)


[![](../../assets/wiki.lckfb.com/storage/logo/logo_cn_dark.svg)![](../../assets/wiki.lckfb.com/storage/logo/logo_cn_light.svg)](/zh-hans/)

简体中文

[English](/en/tspi-rk3566/tool-use/adb-install-use.html)

# [​](#【立创·泰山派rk3566开发板】adb安装与使用教程)

## 文档更新说明 [​](#文档更新说明)

## 免责声明 [​](#免责声明)

本文档虽力求准确，但可能存在错误或遗漏，用户需谨慎评估适用性；我们保留随时修订的权利，且不保证旧版本内容的有效性，为了得到最新版本的产品信息，请定时访问立创开发板官网进行资料的更新下载。本文档版权及最终解释权归深圳嘉立创科技集团股份有限公司所有。请务必注意以上声明，自行评估风险并决策，我们对使用本文档产生的任何问题概不负责。感谢您的包容与支持。

## 前言 [​](#前言)

adb是我们使用到非常高频工具，本文档主要帮助大家快速掌握ADB的安装与使用，并且在泰山派中进行调试试验。

## 准备工作 [​](#准备工作)

* 需要一台win10电脑，其他系统理论上也可以但是我没测试，我这里以我电脑为例，后续所有的环境以及开发编译如果不做特殊说明默认都是基于此配置电脑进行

* 泰山派需烧录对于的Android系统固件
* ADB固件包

## 简介 [​](#简介)

ADB，全称为Android Debug Bridge，是由Google开发的一种命令行工具，用于与Android设备进行通信和调试。作为Android软件开发工具包（SDK）的一部分，ADB提供了一系列功能和命令，方便开发者进行与Android设备交互和调试的操作。

ADB的主要功能和用途如下：

* 设备连接与管理：ADB允许开发者通过USB或网络连接Android设备，并对设备进行管理。可以列出已连接的设备、安装或卸载应用程序、复制文件到设备等操作。
* 应用程序调试：ADB允许开发者在已连接的Android设备上进行应用程序调试。可以启动和停止应用程序、查看应用程序日志、监视CPU和内存使用情况等。
* 文件传输：ADB可以通过命令行在计算机和Android设备之间传输文件。这对于安装应用程序、传输媒体文件或备份数据非常有用。
* Shell访问：ADB提供了一个可以执行设备上的shell命令的接口，方便开发者进行设备调试、日志记录、系统状态查询等操作。
* 截图和屏幕录制：ADB可以进行屏幕截图和录制，以便开发者捕获设备屏幕上的图像和动画，并进行分析和调试。
* 端口转发：ADB支持将设备的端口转发到计算机的端口，方便开发者通过计算机与设备上运行的服务进行通信和调试。
* 设备控制：ADB提供了一些命令来进行基本的设备操作，如重启设备、关机、进入恢复模式等。

需要注意的，是虽然adb是为android开发的但是因为他很好用很流行所以在其他平台我们也是可以看到他的身影比如后面我们用到的buildroot、debian、ubuntu等。

## 安装 [​](#安装)

ADB下载

📌 [下载中心（点击跳转）](/zh-hans/tspi-rk3566/download-center.html)

📌 在 `下载中心`->`百度网盘`->`第07章.【立创·泰山派】开发工具`->`platform-tools_r33.0.3-windows.zip压缩包`中。

> 这个是Windows环境下运行的

下载安装包并解压，我这里直接下载并解压到D:盘，这里可以根据个人情况制定位置但是后面添加环境变量时也需要指定对应路径

此时我们直接在当前目录打开命令行窗口是可以直接使用adb的，打开方法在文件目录栏直接输入cmd并回车

在命令行窗口运行adb.exe help命令能够出现版本信息等表示adb正常。

上面我们adb.exe同目录下运行成功，但是我们实际使用的时候是想在任意位置打开cmd即可使用adb，所以我们需要把adb添加到windows的环境变量中，这里就以win10为例，其他大同小异。

鼠标右键点击win10图片，选择系统。

点击高级系统设置

运行adb help看到以下日志就证明你成功啦~~~~

## 使用 [​](#使用)

### 连接泰山派开发板 [​](#连接泰山派开发板)

* 泰派数据线连接电脑，注意：如果供电不足需要用电源诱骗小板补电，typec要有数据功能不单是充电线

* android系统中打开USB调试，我们提供的固件默认是已经打开了的，手动打开方法：

`进入android系统界面`-->`Settings`-->`About tablet`-->`连续多少点击Build number打开开发者模式`-->`退回上级进入Sysem`-->`Advanced`-->`打开USB debugging选型`

打开设备管理器中能够正确找到`Android ADB Interfaces`设备。

### ADB命令学习方法 [​](#adb命令学习方法)

### 如何快速掌握ADB用法 [​](#如何快速掌握adb用法)

shell

```
C:\Users\win>adb helpC:\Users\win> adb  helpAndroid Debug Bridge version 1.0.41 Android  Debug  Bridge  version 1.0.41Version 34.0.1-9680074 Version 34.0.1-9680074Installed as D:\platform-tools\adb.exe Installed  as D: \platform-tools \adb.exeglobal options: global options: -a listen on all network interfaces, not just localhost -a  listen  on  all  network interfaces,  not  just  localhost -d use USB device (error if multiple devices connected) -d  use  USB  device (error if  multiple  devices  connected) -e use TCP/IP device (error if multiple TCP/IP devices available) -e  use TCP/IP  device (error if  multiple TCP/IP  devices  available) -s SERIAL use device with given serial (overrides $ANDROID_SERIAL) -s  SERIAL  use  device  with  given  serial (overrides $ANDROID_SERIAL) -t ID use device with given transport id -t  ID  use  device  with  given  transport  id -H name of adb server host [default=localhost] -H  name  of  adb  server  host [default=localhost] -P port of adb server [default=5037] -P  port  of  adb  server [default=5037] -L SOCKET listen on given socket for adb server [default=tcp:localhost:5037] -L  SOCKET  listen  on  given  socket  for  adb  server [default=tcp:localhost:5037] --one-device SERIAL|USB only allowed with 'start-server' or 'server nodaemon', server will only connect to one USB device, specified by a serial number or USB device address. --one-device  SERIAL | USB  only  allowed  with 'start-server'  or 'server nodaemon',  server  will  only  connect  to  one  USB device,  specified  by  a  serial  number  or  USB  device address. --exit-on-write-error exit if stdout is closed --exit-on-write-error  exit  if  stdout  is  closedgeneral commands: general commands: devices [-l] list connected devices (-l for long output)help show this help message  devices [-l] list connected devices (-l  for  long  output)help show this help message  version show version num  version  show  version  numnetworking:networking: connect HOST[:PORT] connect to a device via TCP/IP [default port=5555]  connect HOST[:PORT]  connect  to  a  device  via TCP/IP [default port=5555] disconnect [HOST[:PORT]]  disconnect [HOST[:PORT]] disconnect from given TCP/IP device [default port=5555], or all  disconnect  from  given TCP/IP  device [default port=5555],  or  all pair HOST[:PORT] [PAIRING CODE]  pair HOST[:PORT] [PAIRING CODE] pair with a device for secure TCP/IP communication  pair  with  a  device  for  secure TCP/IP  communication forward --list list all forward socket connections  forward --list  list  all  forward  socket  connections forward [--no-rebind] LOCAL REMOTE  forward [--no-rebind] LOCAL REMOTE forward socket connection using:  forward  socket  connection using: tcp: (be "tcp:0" to pick any open port)  localabstract:domain socket name>  localreserved:domain socket name>  localfilesystem:domain socket name>  dev:device name>  jdwp:pid> (remote only)  vsock:: (remote only)  acceptfd: (listen only)  forward --remove LOCAL remove specific forward socket connection  forward --remove-all remove all forward socket connections  reverse --list list all reverse socket connections from device  reverse [--no-rebind] REMOTE LOCAL  reverse socket connection using:  tcp: ( may be "tcp:0" to pick any open port)  localabstract:domain socket name>  localreserved:domain socket name>  localfilesystem:domain socket name>  reverse --remove REMOTE remove specific reverse socket connection  reverse --remove-all remove all reverse socket connections from device  mdns check check if mdns discovery is available  mdns services list all discovered services file transfer:  push [--sync] [-z ALGORITHM] [-Z] LOCAL... REMOTE  copy local files/directories to device  --sync: only push files that are newer on the host than the device  -n: dry run: push files to device without storing to the filesystem  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression  pull [-a] [-z ALGORITHM] [-Z] REMOTE... LOCAL  copy files/dirs from device  -a: preserve file timestamp and mode  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compressionsync [-l] [-z ALGORITHM] [-Z] [all|data|odm|oem|product|system|system_ext|vendor]sync a local build from $ANDROID_PRODUCT_OUT to the device (default all)  -n: dry run: push files to device without storing to the filesystem  -l: list files that would be copied, but don't copy them  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression shell:  shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...]  run remote shell command (interactive shell if no command given)  -e: choose escape character, or "none"; default '~'  -n: don't read from stdin  -T: disable pty allocation  -t: allocate a pty if on a tty (-tt: force pty allocation)  -x: disable remote exit codes and stdout/stderr separation  emu COMMAND run emulator console command app installation (see also `adb shell cmd package help`):  install [-lrtsdg] [--instant] PACKAGE  push a single package to the device and install it  install-multiple [-lrtsdpg] [--instant] PACKAGE...  push multiple APKs to the device for a single package and install them  install-multi-package [-lrtsdpg] [--instant] PACKAGE...  push one or more packages to the device and install them atomically  -r: replace existing application  -t: allow test packages  -d: allow version code downgrade (debuggable packages only)  -p: partial application install (install-multiple only)  -g: grant all runtime permissions  --abi ABI: override platform's default ABI  --instant: cause the app to be installed as an ephemeral install app  --no-streaming: always push APK to device and invoke Package Manager as separate steps  --streaming: force streaming APK directly into Package Manager  --fastdeploy: use fast deploy  --no-fastdeploy: prevent use of fast deploy  --force-agent: force update of deployment agent when using fast deploy  --date-check-agent: update deployment agent when local version is newer and using fast deploy  --version-check-agent: update deployment agent when local version has different version code and using fast deploy  (See also adb shell pm help  for more options.)  uninstall [-k] PACKAGE  remove this app package from the device  '-k': keep the data and cache directories debugging:  bugreport [PATH]  write bugreport to given PATH [default=bugreport.zip];  if PATH is a directory, the bug report is saved in that directory.  devices that don't support zipped bug reports output to stdout.  jdwp list pids of processes hosting a JDWP transport  logcat show device log (logcat --help for more) security:  disable-verity disable dm-verity checking on userdebug builds  enable-verity re-enable dm-verity checking on userdebug builds  keygen FILE  generate adb public/private key; private key stored in FILE, scripting:  wait-for[-TRANSPORT]-STATE...wait for device to be in a given state  STATE: device, recovery, rescue, sideload, bootloader, or disconnect  TRANSPORT: usb, local, or any [default=any]  get-state print offline | bootloader | device  get-serialno print <serial-number>  get-devpath print <device-path>  remount [-R]  remount partitions read-write. if a reboot is required, -R will  will automatically reboot the device.  reboot [bootloader|recovery|sideload|sideload-auto-reboot]  reboot the device; defaults to booting system image but  supports bootloader and recovery too. sideload reboots  into recovery and automatically starts sideload mode,  sideload-auto-reboot is the same but reboots after sideloading.  sideload OTAPACKAGE sideload the given full OTA package  root restart adbd with root permissions  unroot restart adbd without root permissions  usb restart adbd listening on USB  tcpip PORT restart adbd listening on TCP on PORT internal debugging:  start-server ensure that there is a server running  kill-server kill the server if it is running  reconnect kick connection from host side to force reconnect  reconnect device kick connection from device side to force reconnect  reconnect offline reset offline/unauthorized devices to force reconnect usb:  attach attach a detached USB device  detach detach from a USB device to allow use by other processes environment variables:$ADB_TRACE  comma-separated list of debug info to log:  all,adb,sockets,packets,rwx,usb,sync,sysdeps,transport,jdwp$ADB_VENDOR_KEYS colon-separated list of keys (files or directories)$ANDROID_SERIAL serial number to connect to (see -s)$ANDROID_LOG_TAGS tags to be used by logcat (see logcat --help)$ADB_LOCAL_TRANSPORT_MAX_PORT max emulator scan port (default 5585, 16 emus)$ADB_MDNS_AUTO_CONNECT comma-separated list of mdns services to allow auto-connect (default adb-tls-connect) Online documentation: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md tcp: (be "tcp:0" to pick any open port) be "tcp:0"  to  pick  any  open  port) localabstract:domain socket name>  localreserved:domain socket name>  localfilesystem:domain socket name>  dev:device name>  jdwp:pid> (remote only)  vsock:: (remote only)  acceptfd: (listen only)  forward --remove LOCAL remove specific forward socket connection  forward --remove-all remove all forward socket connections  reverse --list list all reverse socket connections from device  reverse [--no-rebind] REMOTE LOCAL  reverse socket connection using:  tcp: ( may be "tcp:0" to pick any open port)  localabstract:domain socket name>  localreserved:domain socket name>  localfilesystem:domain socket name>  reverse --remove REMOTE remove specific reverse socket connection  reverse --remove-all remove all reverse socket connections from device  mdns check check if mdns discovery is available  mdns services list all discovered services file transfer:  push [--sync] [-z ALGORITHM] [-Z] LOCAL... REMOTE  copy local files/directories to device  --sync: only push files that are newer on the host than the device  -n: dry run: push files to device without storing to the filesystem  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression  pull [-a] [-z ALGORITHM] [-Z] REMOTE... LOCAL  copy files/dirs from device  -a: preserve file timestamp and mode  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compressionsync [-l] [-z ALGORITHM] [-Z] [all|data|odm|oem|product|system|system_ext|vendor]sync a local build from $ANDROID_PRODUCT_OUT to the device (default all)  -n: dry run: push files to device without storing to the filesystem  -l: list files that would be copied, but don't copy them  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression shell:  shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...]  run remote shell command (interactive shell if no command given)  -e: choose escape character, or "none"; default '~'  -n: don't read from stdin  -T: disable pty allocation  -t: allocate a pty if on a tty (-tt: force pty allocation)  -x: disable remote exit codes and stdout/stderr separation  emu COMMAND run emulator console command app installation (see also `adb shell cmd package help`):  install [-lrtsdg] [--instant] PACKAGE  push a single package to the device and install it  install-multiple [-lrtsdpg] [--instant] PACKAGE...  push multiple APKs to the device for a single package and install them  install-multi-package [-lrtsdpg] [--instant] PACKAGE...  push one or more packages to the device and install them atomically  -r: replace existing application  -t: allow test packages  -d: allow version code downgrade (debuggable packages only)  -p: partial application install (install-multiple only)  -g: grant all runtime permissions  --abi ABI: override platform's default ABI  --instant: cause the app to be installed as an ephemeral install app  --no-streaming: always push APK to device and invoke Package Manager as separate steps  --streaming: force streaming APK directly into Package Manager  --fastdeploy: use fast deploy  --no-fastdeploy: prevent use of fast deploy  --force-agent: force update of deployment agent when using fast deploy  --date-check-agent: update deployment agent when local version is newer and using fast deploy  --version-check-agent: update deployment agent when local version has different version code and using fast deploy  (See also adb shell pm help  for more options.)  uninstall [-k] PACKAGE  remove this app package from the device  '-k': keep the data and cache directories debugging:  bugreport [PATH]  write bugreport to given PATH [default=bugreport.zip];  if PATH is a directory, the bug report is saved in that directory.  devices that don't support zipped bug reports output to stdout.  jdwp list pids of processes hosting a JDWP transport  logcat show device log (logcat --help for more) security:  disable-verity disable dm-verity checking on userdebug builds  enable-verity re-enable dm-verity checking on userdebug builds  keygen FILE  generate adb public/private key; private key stored in FILE, scripting:  wait-for[-TRANSPORT]-STATE...wait for device to be in a given state  STATE: device, recovery, rescue, sideload, bootloader, or disconnect  TRANSPORT: usb, local, or any [default=any]  get-state print offline | bootloader | device  get-serialno print <serial-number>  get-devpath print <device-path>  remount [-R]  remount partitions read-write. if a reboot is required, -R will  will automatically reboot the device.  reboot [bootloader|recovery|sideload|sideload-auto-reboot]  reboot the device; defaults to booting system image but  supports bootloader and recovery too. sideload reboots  into recovery and automatically starts sideload mode,  sideload-auto-reboot is the same but reboots after sideloading.  sideload OTAPACKAGE sideload the given full OTA package  root restart adbd with root permissions  unroot restart adbd without root permissions  usb restart adbd listening on USB  tcpip PORT restart adbd listening on TCP on PORT internal debugging:  start-server ensure that there is a server running  kill-server kill the server if it is running  reconnect kick connection from host side to force reconnect  reconnect device kick connection from device side to force reconnect  reconnect offline reset offline/unauthorized devices to force reconnect usb:  attach attach a detached USB device  detach detach from a USB device to allow use by other processes environment variables:$ADB_TRACE  comma-separated list of debug info to log:  all,adb,sockets,packets,rwx,usb,sync,sysdeps,transport,jdwp$ADB_VENDOR_KEYS colon-separated list of keys (files or directories)$ANDROID_SERIAL serial number to connect to (see -s)$ANDROID_LOG_TAGS tags to be used by logcat (see logcat --help)$ADB_LOCAL_TRANSPORT_MAX_PORT max emulator scan port (default 5585, 16 emus)$ADB_MDNS_AUTO_CONNECT comma-separated list of mdns services to allow auto-connect (default adb-tls-connect) Online documentation: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md localabstract:domain socket name> domain  socket  nam e> localreserved:domain socket name>  localfilesystem:domain socket name>  dev:device name>  jdwp:pid> (remote only)  vsock:: (remote only)  acceptfd: (listen only)  forward --remove LOCAL remove specific forward socket connection  forward --remove-all remove all forward socket connections  reverse --list list all reverse socket connections from device  reverse [--no-rebind] REMOTE LOCAL  reverse socket connection using:  tcp: ( may be "tcp:0" to pick any open port)  localabstract:domain socket name>  localreserved:domain socket name>  localfilesystem:domain socket name>  reverse --remove REMOTE remove specific reverse socket connection  reverse --remove-all remove all reverse socket connections from device  mdns check check if mdns discovery is available  mdns services list all discovered services file transfer:  push [--sync] [-z ALGORITHM] [-Z] LOCAL... REMOTE  copy local files/directories to device  --sync: only push files that are newer on the host than the device  -n: dry run: push files to device without storing to the filesystem  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression  pull [-a] [-z ALGORITHM] [-Z] REMOTE... LOCAL  copy files/dirs from device  -a: preserve file timestamp and mode  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compressionsync [-l] [-z ALGORITHM] [-Z] [all|data|odm|oem|product|system|system_ext|vendor]sync a local build from $ANDROID_PRODUCT_OUT to the device (default all)  -n: dry run: push files to device without storing to the filesystem  -l: list files that would be copied, but don't copy them  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression shell:  shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...]  run remote shell command (interactive shell if no command given)  -e: choose escape character, or "none"; default '~'  -n: don't read from stdin  -T: disable pty allocation  -t: allocate a pty if on a tty (-tt: force pty allocation)  -x: disable remote exit codes and stdout/stderr separation  emu COMMAND run emulator console command app installation (see also `adb shell cmd package help`):  install [-lrtsdg] [--instant] PACKAGE  push a single package to the device and install it  install-multiple [-lrtsdpg] [--instant] PACKAGE...  push multiple APKs to the device for a single package and install them  install-multi-package [-lrtsdpg] [--instant] PACKAGE...  push one or more packages to the device and install them atomically  -r: replace existing application  -t: allow test packages  -d: allow version code downgrade (debuggable packages only)  -p: partial application install (install-multiple only)  -g: grant all runtime permissions  --abi ABI: override platform's default ABI  --instant: cause the app to be installed as an ephemeral install app  --no-streaming: always push APK to device and invoke Package Manager as separate steps  --streaming: force streaming APK directly into Package Manager  --fastdeploy: use fast deploy  --no-fastdeploy: prevent use of fast deploy  --force-agent: force update of deployment agent when using fast deploy  --date-check-agent: update deployment agent when local version is newer and using fast deploy  --version-check-agent: update deployment agent when local version has different version code and using fast deploy  (See also adb shell pm help  for more options.)  uninstall [-k] PACKAGE  remove this app package from the device  '-k': keep the data and cache directories debugging:  bugreport [PATH]  write bugreport to given PATH [default=bugreport.zip];  if PATH is a directory, the bug report is saved in that directory.  devices that don't support zipped bug reports output to stdout.  jdwp list pids of processes hosting a JDWP transport  logcat show device log (logcat --help for more) security:  disable-verity disable dm-verity checking on userdebug builds  enable-verity re-enable dm-verity checking on userdebug builds  keygen FILE  generate adb public/private key; private key stored in FILE, scripting:  wait-for[-TRANSPORT]-STATE...wait for device to be in a given state  STATE: device, recovery, rescue, sideload, bootloader, or disconnect  TRANSPORT: usb, local, or any [default=any]  get-state print offline | bootloader | device  get-serialno print <serial-number>  get-devpath print <device-path>  remount [-R]  remount partitions read-write. if a reboot is required, -R will  will automatically reboot the device.  reboot [bootloader|recovery|sideload|sideload-auto-reboot]  reboot the device; defaults to booting system image but  supports bootloader and recovery too. sideload reboots  into recovery and automatically starts sideload mode,  sideload-auto-reboot is the same but reboots after sideloading.  sideload OTAPACKAGE sideload the given full OTA package  root restart adbd with root permissions  unroot restart adbd without root permissions  usb restart adbd listening on USB  tcpip PORT restart adbd listening on TCP on PORT internal debugging:  start-server ensure that there is a server running  kill-server kill the server if it is running  reconnect kick connection from host side to force reconnect  reconnect device kick connection from device side to force reconnect  reconnect offline reset offline/unauthorized devices to force reconnect usb:  attach attach a detached USB device  detach detach from a USB device to allow use by other processes environment variables:$ADB_TRACE  comma-separated list of debug info to log:  all,adb,sockets,packets,rwx,usb,sync,sysdeps,transport,jdwp$ADB_VENDOR_KEYS colon-separated list of keys (files or directories)$ANDROID_SERIAL serial number to connect to (see -s)$ANDROID_LOG_TAGS tags to be used by logcat (see logcat --help)$ADB_LOCAL_TRANSPORT_MAX_PORT max emulator scan port (default 5585, 16 emus)$ADB_MDNS_AUTO_CONNECT comma-separated list of mdns services to allow auto-connect (default adb-tls-connect) Online documentation: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md localreserved:domain socket name> domain  socket  nam e> localfilesystem:domain socket name>  dev:device name>  jdwp:pid> (remote only)  vsock:: (remote only)  acceptfd: (listen only)  forward --remove LOCAL remove specific forward socket connection  forward --remove-all remove all forward socket connections  reverse --list list all reverse socket connections from device  reverse [--no-rebind] REMOTE LOCAL  reverse socket connection using:  tcp: ( may be "tcp:0" to pick any open port)  localabstract:domain socket name>  localreserved:domain socket name>  localfilesystem:domain socket name>  reverse --remove REMOTE remove specific reverse socket connection  reverse --remove-all remove all reverse socket connections from device  mdns check check if mdns discovery is available  mdns services list all discovered services file transfer:  push [--sync] [-z ALGORITHM] [-Z] LOCAL... REMOTE  copy local files/directories to device  --sync: only push files that are newer on the host than the device  -n: dry run: push files to device without storing to the filesystem  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression  pull [-a] [-z ALGORITHM] [-Z] REMOTE... LOCAL  copy files/dirs from device  -a: preserve file timestamp and mode  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compressionsync [-l] [-z ALGORITHM] [-Z] [all|data|odm|oem|product|system|system_ext|vendor]sync a local build from $ANDROID_PRODUCT_OUT to the device (default all)  -n: dry run: push files to device without storing to the filesystem  -l: list files that would be copied, but don't copy them  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression shell:  shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...]  run remote shell command (interactive shell if no command given)  -e: choose escape character, or "none"; default '~'  -n: don't read from stdin  -T: disable pty allocation  -t: allocate a pty if on a tty (-tt: force pty allocation)  -x: disable remote exit codes and stdout/stderr separation  emu COMMAND run emulator console command app installation (see also `adb shell cmd package help`):  install [-lrtsdg] [--instant] PACKAGE  push a single package to the device and install it  install-multiple [-lrtsdpg] [--instant] PACKAGE...  push multiple APKs to the device for a single package and install them  install-multi-package [-lrtsdpg] [--instant] PACKAGE...  push one or more packages to the device and install them atomically  -r: replace existing application  -t: allow test packages  -d: allow version code downgrade (debuggable packages only)  -p: partial application install (install-multiple only)  -g: grant all runtime permissions  --abi ABI: override platform's default ABI  --instant: cause the app to be installed as an ephemeral install app  --no-streaming: always push APK to device and invoke Package Manager as separate steps  --streaming: force streaming APK directly into Package Manager  --fastdeploy: use fast deploy  --no-fastdeploy: prevent use of fast deploy  --force-agent: force update of deployment agent when using fast deploy  --date-check-agent: update deployment agent when local version is newer and using fast deploy  --version-check-agent: update deployment agent when local version has different version code and using fast deploy  (See also adb shell pm help  for more options.)  uninstall [-k] PACKAGE  remove this app package from the device  '-k': keep the data and cache directories debugging:  bugreport [PATH]  write bugreport to given PATH [default=bugreport.zip];  if PATH is a directory, the bug report is saved in that directory.  devices that don't support zipped bug reports output to stdout.  jdwp list pids of processes hosting a JDWP transport  logcat show device log (logcat --help for more) security:  disable-verity disable dm-verity checking on userdebug builds  enable-verity re-enable dm-verity checking on userdebug builds  keygen FILE  generate adb public/private key; private key stored in FILE, scripting:  wait-for[-TRANSPORT]-STATE...wait for device to be in a given state  STATE: device, recovery, rescue, sideload, bootloader, or disconnect  TRANSPORT: usb, local, or any [default=any]  get-state print offline | bootloader | device  get-serialno print <serial-number>  get-devpath print <device-path>  remount [-R]  remount partitions read-write. if a reboot is required, -R will  will automatically reboot the device.  reboot [bootloader|recovery|sideload|sideload-auto-reboot]  reboot the device; defaults to booting system image but  supports bootloader and recovery too. sideload reboots  into recovery and automatically starts sideload mode,  sideload-auto-reboot is the same but reboots after sideloading.  sideload OTAPACKAGE sideload the given full OTA package  root restart adbd with root permissions  unroot restart adbd without root permissions  usb restart adbd listening on USB  tcpip PORT restart adbd listening on TCP on PORT internal debugging:  start-server ensure that there is a server running  kill-server kill the server if it is running  reconnect kick connection from host side to force reconnect  reconnect device kick connection from device side to force reconnect  reconnect offline reset offline/unauthorized devices to force reconnect usb:  attach attach a detached USB device  detach detach from a USB device to allow use by other processes environment variables:$ADB_TRACE  comma-separated list of debug info to log:  all,adb,sockets,packets,rwx,usb,sync,sysdeps,transport,jdwp$ADB_VENDOR_KEYS colon-separated list of keys (files or directories)$ANDROID_SERIAL serial number to connect to (see -s)$ANDROID_LOG_TAGS tags to be used by logcat (see logcat --help)$ADB_LOCAL_TRANSPORT_MAX_PORT max emulator scan port (default 5585, 16 emus)$ADB_MDNS_AUTO_CONNECT comma-separated list of mdns services to allow auto-connect (default adb-tls-connect) Online documentation: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md localfilesystem:domain socket name> domain  socket  nam e> dev:device name>  jdwp:pid> (remote only)  vsock:: (remote only)  acceptfd: (listen only)  forward --remove LOCAL remove specific forward socket connection  forward --remove-all remove all forward socket connections  reverse --list list all reverse socket connections from device  reverse [--no-rebind] REMOTE LOCAL  reverse socket connection using:  tcp: ( may be "tcp:0" to pick any open port)  localabstract:domain socket name>  localreserved:domain socket name>  localfilesystem:domain socket name>  reverse --remove REMOTE remove specific reverse socket connection  reverse --remove-all remove all reverse socket connections from device  mdns check check if mdns discovery is available  mdns services list all discovered services file transfer:  push [--sync] [-z ALGORITHM] [-Z] LOCAL... REMOTE  copy local files/directories to device  --sync: only push files that are newer on the host than the device  -n: dry run: push files to device without storing to the filesystem  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression  pull [-a] [-z ALGORITHM] [-Z] REMOTE... LOCAL  copy files/dirs from device  -a: preserve file timestamp and mode  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compressionsync [-l] [-z ALGORITHM] [-Z] [all|data|odm|oem|product|system|system_ext|vendor]sync a local build from $ANDROID_PRODUCT_OUT to the device (default all)  -n: dry run: push files to device without storing to the filesystem  -l: list files that would be copied, but don't copy them  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression shell:  shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...]  run remote shell command (interactive shell if no command given)  -e: choose escape character, or "none"; default '~'  -n: don't read from stdin  -T: disable pty allocation  -t: allocate a pty if on a tty (-tt: force pty allocation)  -x: disable remote exit codes and stdout/stderr separation  emu COMMAND run emulator console command app installation (see also `adb shell cmd package help`):  install [-lrtsdg] [--instant] PACKAGE  push a single package to the device and install it  install-multiple [-lrtsdpg] [--instant] PACKAGE...  push multiple APKs to the device for a single package and install them  install-multi-package [-lrtsdpg] [--instant] PACKAGE...  push one or more packages to the device and install them atomically  -r: replace existing application  -t: allow test packages  -d: allow version code downgrade (debuggable packages only)  -p: partial application install (install-multiple only)  -g: grant all runtime permissions  --abi ABI: override platform's default ABI  --instant: cause the app to be installed as an ephemeral install app  --no-streaming: always push APK to device and invoke Package Manager as separate steps  --streaming: force streaming APK directly into Package Manager  --fastdeploy: use fast deploy  --no-fastdeploy: prevent use of fast deploy  --force-agent: force update of deployment agent when using fast deploy  --date-check-agent: update deployment agent when local version is newer and using fast deploy  --version-check-agent: update deployment agent when local version has different version code and using fast deploy  (See also adb shell pm help  for more options.)  uninstall [-k] PACKAGE  remove this app package from the device  '-k': keep the data and cache directories debugging:  bugreport [PATH]  write bugreport to given PATH [default=bugreport.zip];  if PATH is a directory, the bug report is saved in that directory.  devices that don't support zipped bug reports output to stdout.  jdwp list pids of processes hosting a JDWP transport  logcat show device log (logcat --help for more) security:  disable-verity disable dm-verity checking on userdebug builds  enable-verity re-enable dm-verity checking on userdebug builds  keygen FILE  generate adb public/private key; private key stored in FILE, scripting:  wait-for[-TRANSPORT]-STATE...wait for device to be in a given state  STATE: device, recovery, rescue, sideload, bootloader, or disconnect  TRANSPORT: usb, local, or any [default=any]  get-state print offline | bootloader | device  get-serialno print <serial-number>  get-devpath print <device-path>  remount [-R]  remount partitions read-write. if a reboot is required, -R will  will automatically reboot the device.  reboot [bootloader|recovery|sideload|sideload-auto-reboot]  reboot the device; defaults to booting system image but  supports bootloader and recovery too. sideload reboots  into recovery and automatically starts sideload mode,  sideload-auto-reboot is the same but reboots after sideloading.  sideload OTAPACKAGE sideload the given full OTA package  root restart adbd with root permissions  unroot restart adbd without root permissions  usb restart adbd listening on USB  tcpip PORT restart adbd listening on TCP on PORT internal debugging:  start-server ensure that there is a server running  kill-server kill the server if it is running  reconnect kick connection from host side to force reconnect  reconnect device kick connection from device side to force reconnect  reconnect offline reset offline/unauthorized devices to force reconnect usb:  attach attach a detached USB device  detach detach from a USB device to allow use by other processes environment variables:$ADB_TRACE  comma-separated list of debug info to log:  all,adb,sockets,packets,rwx,usb,sync,sysdeps,transport,jdwp$ADB_VENDOR_KEYS colon-separated list of keys (files or directories)$ANDROID_SERIAL serial number to connect to (see -s)$ANDROID_LOG_TAGS tags to be used by logcat (see logcat --help)$ADB_LOCAL_TRANSPORT_MAX_PORT max emulator scan port (default 5585, 16 emus)$ADB_MDNS_AUTO_CONNECT comma-separated list of mdns services to allow auto-connect (default adb-tls-connect) Online documentation: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md dev:device name> device  nam e> jdwp:pid> (remote only)  vsock:: (remote only)  acceptfd: (listen only)  forward --remove LOCAL remove specific forward socket connection  forward --remove-all remove all forward socket connections  reverse --list list all reverse socket connections from device  reverse [--no-rebind] REMOTE LOCAL  reverse socket connection using:  tcp: ( may be "tcp:0" to pick any open port)  localabstract:domain socket name>  localreserved:domain socket name>  localfilesystem:domain socket name>  reverse --remove REMOTE remove specific reverse socket connection  reverse --remove-all remove all reverse socket connections from device  mdns check check if mdns discovery is available  mdns services list all discovered services file transfer:  push [--sync] [-z ALGORITHM] [-Z] LOCAL... REMOTE  copy local files/directories to device  --sync: only push files that are newer on the host than the device  -n: dry run: push files to device without storing to the filesystem  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression  pull [-a] [-z ALGORITHM] [-Z] REMOTE... LOCAL  copy files/dirs from device  -a: preserve file timestamp and mode  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compressionsync [-l] [-z ALGORITHM] [-Z] [all|data|odm|oem|product|system|system_ext|vendor]sync a local build from $ANDROID_PRODUCT_OUT to the device (default all)  -n: dry run: push files to device without storing to the filesystem  -l: list files that would be copied, but don't copy them  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression shell:  shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...]  run remote shell command (interactive shell if no command given)  -e: choose escape character, or "none"; default '~'  -n: don't read from stdin  -T: disable pty allocation  -t: allocate a pty if on a tty (-tt: force pty allocation)  -x: disable remote exit codes and stdout/stderr separation  emu COMMAND run emulator console command app installation (see also `adb shell cmd package help`):  install [-lrtsdg] [--instant] PACKAGE  push a single package to the device and install it  install-multiple [-lrtsdpg] [--instant] PACKAGE...  push multiple APKs to the device for a single package and install them  install-multi-package [-lrtsdpg] [--instant] PACKAGE...  push one or more packages to the device and install them atomically  -r: replace existing application  -t: allow test packages  -d: allow version code downgrade (debuggable packages only)  -p: partial application install (install-multiple only)  -g: grant all runtime permissions  --abi ABI: override platform's default ABI  --instant: cause the app to be installed as an ephemeral install app  --no-streaming: always push APK to device and invoke Package Manager as separate steps  --streaming: force streaming APK directly into Package Manager  --fastdeploy: use fast deploy  --no-fastdeploy: prevent use of fast deploy  --force-agent: force update of deployment agent when using fast deploy  --date-check-agent: update deployment agent when local version is newer and using fast deploy  --version-check-agent: update deployment agent when local version has different version code and using fast deploy  (See also adb shell pm help  for more options.)  uninstall [-k] PACKAGE  remove this app package from the device  '-k': keep the data and cache directories debugging:  bugreport [PATH]  write bugreport to given PATH [default=bugreport.zip];  if PATH is a directory, the bug report is saved in that directory.  devices that don't support zipped bug reports output to stdout.  jdwp list pids of processes hosting a JDWP transport  logcat show device log (logcat --help for more) security:  disable-verity disable dm-verity checking on userdebug builds  enable-verity re-enable dm-verity checking on userdebug builds  keygen FILE  generate adb public/private key; private key stored in FILE, scripting:  wait-for[-TRANSPORT]-STATE...wait for device to be in a given state  STATE: device, recovery, rescue, sideload, bootloader, or disconnect  TRANSPORT: usb, local, or any [default=any]  get-state print offline | bootloader | device  get-serialno print <serial-number>  get-devpath print <device-path>  remount [-R]  remount partitions read-write. if a reboot is required, -R will  will automatically reboot the device.  reboot [bootloader|recovery|sideload|sideload-auto-reboot]  reboot the device; defaults to booting system image but  supports bootloader and recovery too. sideload reboots  into recovery and automatically starts sideload mode,  sideload-auto-reboot is the same but reboots after sideloading.  sideload OTAPACKAGE sideload the given full OTA package  root restart adbd with root permissions  unroot restart adbd without root permissions  usb restart adbd listening on USB  tcpip PORT restart adbd listening on TCP on PORT internal debugging:  start-server ensure that there is a server running  kill-server kill the server if it is running  reconnect kick connection from host side to force reconnect  reconnect device kick connection from device side to force reconnect  reconnect offline reset offline/unauthorized devices to force reconnect usb:  attach attach a detached USB device  detach detach from a USB device to allow use by other processes environment variables:$ADB_TRACE  comma-separated list of debug info to log:  all,adb,sockets,packets,rwx,usb,sync,sysdeps,transport,jdwp$ADB_VENDOR_KEYS colon-separated list of keys (files or directories)$ANDROID_SERIAL serial number to connect to (see -s)$ANDROID_LOG_TAGS tags to be used by logcat (see logcat --help)$ADB_LOCAL_TRANSPORT_MAX_PORT max emulator scan port (default 5585, 16 emus)$ADB_MDNS_AUTO_CONNECT comma-separated list of mdns services to allow auto-connect (default adb-tls-connect) Online documentation: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md jdwp:pid> (remote only) pi d> (remote only) vsock:: (remote only) vsock:: (remote only) acceptfd: (listen only) acceptfd: (listen only) forward --remove LOCAL remove specific forward socket connection  forward --remove  LOCAL  remove  specific  forward  socket  connection forward --remove-all remove all forward socket connections  forward --remove-all  remove  all  forward  socket  connections reverse --list list all reverse socket connections from device  reverse --list  list  all  reverse  socket  connections  from  device reverse [--no-rebind] REMOTE LOCAL  reverse [--no-rebind] REMOTE LOCAL reverse socket connection using:  reverse  socket  connection using: tcp: ( may be "tcp:0" to pick any open port) tcp: ( may  be "tcp:0"  to  pick  any  open  port) localabstract:domain socket name>  localreserved:domain socket name>  localfilesystem:domain socket name>  reverse --remove REMOTE remove specific reverse socket connection  reverse --remove-all remove all reverse socket connections from device  mdns check check if mdns discovery is available  mdns services list all discovered services file transfer:  push [--sync] [-z ALGORITHM] [-Z] LOCAL... REMOTE  copy local files/directories to device  --sync: only push files that are newer on the host than the device  -n: dry run: push files to device without storing to the filesystem  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression  pull [-a] [-z ALGORITHM] [-Z] REMOTE... LOCAL  copy files/dirs from device  -a: preserve file timestamp and mode  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compressionsync [-l] [-z ALGORITHM] [-Z] [all|data|odm|oem|product|system|system_ext|vendor]sync a local build from $ANDROID_PRODUCT_OUT to the device (default all)  -n: dry run: push files to device without storing to the filesystem  -l: list files that would be copied, but don't copy them  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression shell:  shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...]  run remote shell command (interactive shell if no command given)  -e: choose escape character, or "none"; default '~'  -n: don't read from stdin  -T: disable pty allocation  -t: allocate a pty if on a tty (-tt: force pty allocation)  -x: disable remote exit codes and stdout/stderr separation  emu COMMAND run emulator console command app installation (see also `adb shell cmd package help`):  install [-lrtsdg] [--instant] PACKAGE  push a single package to the device and install it  install-multiple [-lrtsdpg] [--instant] PACKAGE...  push multiple APKs to the device for a single package and install them  install-multi-package [-lrtsdpg] [--instant] PACKAGE...  push one or more packages to the device and install them atomically  -r: replace existing application  -t: allow test packages  -d: allow version code downgrade (debuggable packages only)  -p: partial application install (install-multiple only)  -g: grant all runtime permissions  --abi ABI: override platform's default ABI  --instant: cause the app to be installed as an ephemeral install app  --no-streaming: always push APK to device and invoke Package Manager as separate steps  --streaming: force streaming APK directly into Package Manager  --fastdeploy: use fast deploy  --no-fastdeploy: prevent use of fast deploy  --force-agent: force update of deployment agent when using fast deploy  --date-check-agent: update deployment agent when local version is newer and using fast deploy  --version-check-agent: update deployment agent when local version has different version code and using fast deploy  (See also adb shell pm help  for more options.)  uninstall [-k] PACKAGE  remove this app package from the device  '-k': keep the data and cache directories debugging:  bugreport [PATH]  write bugreport to given PATH [default=bugreport.zip];  if PATH is a directory, the bug report is saved in that directory.  devices that don't support zipped bug reports output to stdout.  jdwp list pids of processes hosting a JDWP transport  logcat show device log (logcat --help for more) security:  disable-verity disable dm-verity checking on userdebug builds  enable-verity re-enable dm-verity checking on userdebug builds  keygen FILE  generate adb public/private key; private key stored in FILE, scripting:  wait-for[-TRANSPORT]-STATE...wait for device to be in a given state  STATE: device, recovery, rescue, sideload, bootloader, or disconnect  TRANSPORT: usb, local, or any [default=any]  get-state print offline | bootloader | device  get-serialno print <serial-number>  get-devpath print <device-path>  remount [-R]  remount partitions read-write. if a reboot is required, -R will  will automatically reboot the device.  reboot [bootloader|recovery|sideload|sideload-auto-reboot]  reboot the device; defaults to booting system image but  supports bootloader and recovery too. sideload reboots  into recovery and automatically starts sideload mode,  sideload-auto-reboot is the same but reboots after sideloading.  sideload OTAPACKAGE sideload the given full OTA package  root restart adbd with root permissions  unroot restart adbd without root permissions  usb restart adbd listening on USB  tcpip PORT restart adbd listening on TCP on PORT internal debugging:  start-server ensure that there is a server running  kill-server kill the server if it is running  reconnect kick connection from host side to force reconnect  reconnect device kick connection from device side to force reconnect  reconnect offline reset offline/unauthorized devices to force reconnect usb:  attach attach a detached USB device  detach detach from a USB device to allow use by other processes environment variables:$ADB_TRACE  comma-separated list of debug info to log:  all,adb,sockets,packets,rwx,usb,sync,sysdeps,transport,jdwp$ADB_VENDOR_KEYS colon-separated list of keys (files or directories)$ANDROID_SERIAL serial number to connect to (see -s)$ANDROID_LOG_TAGS tags to be used by logcat (see logcat --help)$ADB_LOCAL_TRANSPORT_MAX_PORT max emulator scan port (default 5585, 16 emus)$ADB_MDNS_AUTO_CONNECT comma-separated list of mdns services to allow auto-connect (default adb-tls-connect) Online documentation: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md localabstract:domain socket name> domain  socket  nam e> localreserved:domain socket name>  localfilesystem:domain socket name>  reverse --remove REMOTE remove specific reverse socket connection  reverse --remove-all remove all reverse socket connections from device  mdns check check if mdns discovery is available  mdns services list all discovered services file transfer:  push [--sync] [-z ALGORITHM] [-Z] LOCAL... REMOTE  copy local files/directories to device  --sync: only push files that are newer on the host than the device  -n: dry run: push files to device without storing to the filesystem  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression  pull [-a] [-z ALGORITHM] [-Z] REMOTE... LOCAL  copy files/dirs from device  -a: preserve file timestamp and mode  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compressionsync [-l] [-z ALGORITHM] [-Z] [all|data|odm|oem|product|system|system_ext|vendor]sync a local build from $ANDROID_PRODUCT_OUT to the device (default all)  -n: dry run: push files to device without storing to the filesystem  -l: list files that would be copied, but don't copy them  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression shell:  shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...]  run remote shell command (interactive shell if no command given)  -e: choose escape character, or "none"; default '~'  -n: don't read from stdin  -T: disable pty allocation  -t: allocate a pty if on a tty (-tt: force pty allocation)  -x: disable remote exit codes and stdout/stderr separation  emu COMMAND run emulator console command app installation (see also `adb shell cmd package help`):  install [-lrtsdg] [--instant] PACKAGE  push a single package to the device and install it  install-multiple [-lrtsdpg] [--instant] PACKAGE...  push multiple APKs to the device for a single package and install them  install-multi-package [-lrtsdpg] [--instant] PACKAGE...  push one or more packages to the device and install them atomically  -r: replace existing application  -t: allow test packages  -d: allow version code downgrade (debuggable packages only)  -p: partial application install (install-multiple only)  -g: grant all runtime permissions  --abi ABI: override platform's default ABI  --instant: cause the app to be installed as an ephemeral install app  --no-streaming: always push APK to device and invoke Package Manager as separate steps  --streaming: force streaming APK directly into Package Manager  --fastdeploy: use fast deploy  --no-fastdeploy: prevent use of fast deploy  --force-agent: force update of deployment agent when using fast deploy  --date-check-agent: update deployment agent when local version is newer and using fast deploy  --version-check-agent: update deployment agent when local version has different version code and using fast deploy  (See also adb shell pm help  for more options.)  uninstall [-k] PACKAGE  remove this app package from the device  '-k': keep the data and cache directories debugging:  bugreport [PATH]  write bugreport to given PATH [default=bugreport.zip];  if PATH is a directory, the bug report is saved in that directory.  devices that don't support zipped bug reports output to stdout.  jdwp list pids of processes hosting a JDWP transport  logcat show device log (logcat --help for more) security:  disable-verity disable dm-verity checking on userdebug builds  enable-verity re-enable dm-verity checking on userdebug builds  keygen FILE  generate adb public/private key; private key stored in FILE, scripting:  wait-for[-TRANSPORT]-STATE...wait for device to be in a given state  STATE: device, recovery, rescue, sideload, bootloader, or disconnect  TRANSPORT: usb, local, or any [default=any]  get-state print offline | bootloader | device  get-serialno print <serial-number>  get-devpath print <device-path>  remount [-R]  remount partitions read-write. if a reboot is required, -R will  will automatically reboot the device.  reboot [bootloader|recovery|sideload|sideload-auto-reboot]  reboot the device; defaults to booting system image but  supports bootloader and recovery too. sideload reboots  into recovery and automatically starts sideload mode,  sideload-auto-reboot is the same but reboots after sideloading.  sideload OTAPACKAGE sideload the given full OTA package  root restart adbd with root permissions  unroot restart adbd without root permissions  usb restart adbd listening on USB  tcpip PORT restart adbd listening on TCP on PORT internal debugging:  start-server ensure that there is a server running  kill-server kill the server if it is running  reconnect kick connection from host side to force reconnect  reconnect device kick connection from device side to force reconnect  reconnect offline reset offline/unauthorized devices to force reconnect usb:  attach attach a detached USB device  detach detach from a USB device to allow use by other processes environment variables:$ADB_TRACE  comma-separated list of debug info to log:  all,adb,sockets,packets,rwx,usb,sync,sysdeps,transport,jdwp$ADB_VENDOR_KEYS colon-separated list of keys (files or directories)$ANDROID_SERIAL serial number to connect to (see -s)$ANDROID_LOG_TAGS tags to be used by logcat (see logcat --help)$ADB_LOCAL_TRANSPORT_MAX_PORT max emulator scan port (default 5585, 16 emus)$ADB_MDNS_AUTO_CONNECT comma-separated list of mdns services to allow auto-connect (default adb-tls-connect) Online documentation: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md localreserved:domain socket name> domain  socket  nam e> localfilesystem:domain socket name>  reverse --remove REMOTE remove specific reverse socket connection  reverse --remove-all remove all reverse socket connections from device  mdns check check if mdns discovery is available  mdns services list all discovered services file transfer:  push [--sync] [-z ALGORITHM] [-Z] LOCAL... REMOTE  copy local files/directories to device  --sync: only push files that are newer on the host than the device  -n: dry run: push files to device without storing to the filesystem  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression  pull [-a] [-z ALGORITHM] [-Z] REMOTE... LOCAL  copy files/dirs from device  -a: preserve file timestamp and mode  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compressionsync [-l] [-z ALGORITHM] [-Z] [all|data|odm|oem|product|system|system_ext|vendor]sync a local build from $ANDROID_PRODUCT_OUT to the device (default all)  -n: dry run: push files to device without storing to the filesystem  -l: list files that would be copied, but don't copy them  -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd)  -Z: disable compression shell:  shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...]  run remote shell command (interactive shell if no command given)  -e: choose escape character, or "none"; default '~'  -n: don't read from stdin  -T: disable pty allocation  -t: allocate a pty if on a tty (-tt: force pty allocation)  -x: disable remote exit codes and stdout/stderr separation  emu COMMAND run emulator console command app installation (see also `adb shell cmd package help`):  install [-lrtsdg] [--instant] PACKAGE  push a single package to the device and install it  install-multiple [-lrtsdpg] [--instant] PACKAGE...  push multiple APKs to the device for a single package and install them  install-multi-package [-lrtsdpg] [--instant] PACKAGE...  push one or more packages to the device and install them atomically  -r: replace existing application  -t: allow test packages  -d: allow version code downgrade (debuggable packages only)  -p: partial application install (install-multiple only)  -g: grant all runtime permissions  --abi ABI: override platform's default ABI  --instant: cause the app to be installed as an ephemeral install app  --no-streaming: always push APK to device and invoke Package Manager as separate steps  --streaming: force streaming APK directly into Package Manager  --fastdeploy: use fast deploy  --no-fastdeploy: prevent use of fast deploy  --force-agent: force update of deployment agent when using fast deploy  --date-check-agent: update deployment agent when local version is newer and using fast deploy  --version-check-agent: update deployment agent when local version has different version code and using fast deploy  (See also adb shell pm help  for more options.)  uninstall [-k] PACKAGE  remove this app package from the device  '-k': keep the data and cache directories debugging:  bugreport [PATH]  write bugreport to given PATH [default=bugreport.zip];  if PATH is a directory, the bug report is saved in that directory.  devices that don't support zipped bug reports output to stdout.  jdwp list pids of processes hosting a JDWP transport  logcat show device log (logcat --help for more) security:  disable-verity disable dm-verity checking on userdebug builds  enable-verity re-enable dm-verity checking on userdebug builds  keygen FILE  generate adb public/private key; private key stored in FILE, scripting:  wait-for[-TRANSPORT]-STATE...wait for device to be in a given state  STATE: device, recovery, rescue, sideload, bootloader, or disconnect  TRANSPORT: usb, local, or any [default=any]  get-state print offline | bootloader | device  get-serialno print <serial-number>  get-devpath print <device-path>  remount [-R]  remount partitions read-write. if a reboot is required, -R will  will automatically reboot the device.  reboot [bootloader|recovery|sideload|sideload-auto-reboot]  reboot the device; defaults to booting system image but  supports bootloader and recovery too. sideload reboots  into recovery and automatically starts sideload mode,  sideload-auto-reboot is the same but reboots after sideloading.  sideload OTAPACKAGE sideload the given full OTA package  root restart adbd with root permissions  unroot restart adbd without root permissions  usb restart adbd listening on USB  tcpip PORT restart adbd listening on TCP on PORT internal debugging:  start-server ensure that there is a server running  kill-server kill the server if it is running  reconnect kick connection from host side to force reconnect  reconnect device kick connection from device side to force reconnect  reconnect offline reset offline/unauthorized devices to force reconnect usb:  attach attach a detached USB device  detach detach from a USB device to allow use by other processes environment variables:$ADB_TRACE  comma-separated list of debug info to log:  all,adb,sockets,packets,rwx,usb,sync,sysdeps,transport,jdwp$ADB_VENDOR_KEYS colon-separated list of keys (files or directories)$ANDROID_SERIAL serial number to connect to (see -s)$ANDROID_LOG_TAGS tags to be used by logcat (see logcat --help)$ADB_LOCAL_TRANSPORT_MAX_PORT max emulator scan port (default 5585, 16 emus)$ADB_MDNS_AUTO_CONNECT comma-separated list of mdns services to allow auto-connect (default adb-tls-connect) Online documentation: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md localfilesystem:domain socket name> domain  socket  nam e> reverse --remove REMOTE remove specific reverse socket connection  reverse --remove  REMOTE  remove  specific  reverse  socket  connection reverse --remove-all remove all reverse socket connections from device  reverse --remove-all  remove  all  reverse  socket  connections  from  device  mdns check check if mdns discovery is available  mdns  check  check  if  mdns  discovery  is  available  mdns services list all discovered services  mdns  services  list  all  discovered  servicesfile transfer: file transfer: push [--sync] [-z ALGORITHM] [-Z] LOCAL... REMOTE  push [--sync] [-z ALGORITHM] [-Z] LOCAL... REMOTE copy local files/directories to device  copy  local files/directories  to  device --sync: only push files that are newer on the host than the device --sync:  only  push  files  that  are  newer  on  the  host  than  the  device -n: dry run: push files to device without storing to the filesystem -n:  dry run:  push  files  to  device  without  storing  to  the  filesystem -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd) -z:  enable  compression  with  a  specified  algorithm (any/none/brotli/lz4/zstd) -Z: disable compression -Z:  disable  compression pull [-a] [-z ALGORITHM] [-Z] REMOTE... LOCAL  pull [-a] [-z ALGORITHM] [-Z] REMOTE... LOCAL copy files/dirs from device  copy files/dirs  from  device -a: preserve file timestamp and mode -a:  preserve  file  timestamp  and  mode -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd) -z:  enable  compression  with  a  specified  algorithm (any/none/brotli/lz4/zstd) -Z: disable compressionsync [-l] [-z ALGORITHM] [-Z] [all|data|odm|oem|product|system|system_ext|vendor]sync a local build from $ANDROID_PRODUCT_OUT to the device (default all) -Z:  disable  compressionsync [-l] [-z ALGORITHM] [-Z] [all | data | odm | oem | product | system | system_ext |vendor]sync a local build from $ANDROID_PRODUCT_OUT to the device (default  all) -n: dry run: push files to device without storing to the filesystem -n:  dry run:  push  files  to  device  without  storing  to  the  filesystem -l: list files that would be copied, but don't copy them -l:  list  files  that  would  be copied,  but  don't copy them -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd) -z: enable compression with a specified algorithm (any/none/brotli/lz4/zstd) -Z: disable compression -Z: disable compressionshell:shell: shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...] shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...] run remote shell command (interactive shell if no command given) run remote shell command (interactive shell if no command given) -e: choose escape character, or "none"; default '~' -e: choose escape character, or "none"; default '~' -n: don't read from stdin -n: don't  read  from  stdin -T: disable pty allocation -T:  disable  pty  allocation -t: allocate a pty if on a tty (-tt: force pty allocation) -t:  allocate  a  pty  if  on  a  tty (-tt: force  pty  allocation) -x: disable remote exit codes and stdout/stderr separation -x:  disable  remote  exit  codes  and stdout/stderr  separation  emu COMMAND run emulator console command  emu  COMMAND  run  emulator  console  commandapp installation (see also `adb shell cmd package help`): app  installation (see also  ` adb  shell cmd package help`): install [-lrtsdg] [--instant] PACKAGE  install [-lrtsdg] [--instant] PACKAGE  push a single package to the device and install it  push  a  single  package  to  the  device  and  install  it install-multiple [-lrtsdpg] [--instant] PACKAGE... install-multiple [-lrtsdpg] [--instant] PACKAGE...  push multiple APKs to the device for a single package and install them  push  multiple  APKs  to  the  device  for  a  single  package  and  install  them install-multi-package [-lrtsdpg] [--instant] PACKAGE... install-multi-package [-lrtsdpg] [--instant] PACKAGE...  push one or more packages to the device and install them atomically  push  one  or  more  packages  to  the  device  and  install  them  atomically -r: replace existing application -r:  replace  existing  application -t: allow test packages -t:  allow  test  packages -d: allow version code downgrade (debuggable packages only) -d:  allow  version  code  downgrade (debuggable packages  only) -p: partial application install (install-multiple only) -p:  partial  application  install (install-multiple only) -g: grant all runtime permissions -g:  grant  all  runtime  permissions --abi ABI: override platform's default ABI --abi ABI:  override  platform's default ABI --instant: cause the app to be installed as an ephemeral install app --instant: cause the app to be installed as an ephemeral install app --no-streaming: always push APK to device and invoke Package Manager as separate steps --no-streaming: always push APK to device and invoke Package Manager as separate steps --streaming: force streaming APK directly into Package Manager --streaming: force streaming APK directly into Package Manager --fastdeploy: use fast deploy --fastdeploy: use fast deploy --no-fastdeploy: prevent use of fast deploy --no-fastdeploy: prevent use of fast deploy --force-agent: force update of deployment agent when using fast deploy --force-agent: force update of deployment agent when using fast deploy --date-check-agent: update deployment agent when local version is newer and using fast deploy --date-check-agent: update deployment agent when local version is newer and using fast deploy --version-check-agent: update deployment agent when local version has different version code and using fast deploy --version-check-agent: update deployment agent when local version has different version code and using fast deploy (See also (See also adb shell pm help adb shell pm help for more options.) for more options.) uninstall [-k] PACKAGE uninstall [-k] PACKAGE  remove this app package from the device  remove this app package from the device '-k': keep the data and cache directories '-k': keep the data and cache directoriesdebugging:debugging: bugreport [PATH] bugreport [PATH] write bugreport to given PATH [default=bugreport.zip]; write bugreport to given PATH [default=bugreport.zip]; if PATH is a directory, the bug report is saved in that directory. if PATH is a directory, the bug report is saved in that directory. devices that don't support zipped bug reports output to stdout.  devices that don't  support  zipped  bug  reports  output  to stdout.  jdwp list pids of processes hosting a JDWP transport  jdwp  list  pids  of  processes  hosting  a  JDWP  transport logcat show device log (logcat --help for more)  logcat  show  device  log (logcat --help  for  more)security:security: disable-verity disable dm-verity checking on userdebug builds disable-verity  disable dm-verity  checking  on  userdebug  builds enable-verity re-enable dm-verity checking on userdebug builds enable-verity re-enable dm-verity  checking  on  userdebug  builds  keygen FILE  keygen  FILE generate adb public/private key; private key stored in FILE,  generate  adb public/private  key; private  key  stored  in FILE,scripting:scripting: wait-for[-TRANSPORT]-STATE...wait for device to be in a given state wait-for[-TRANSPORT]-STATE...wait  for  device  to  be  in  a  given  state STATE: device, recovery, rescue, sideload, bootloader, or disconnect STATE: device, recovery, rescue, sideload, bootloader,  or  disconnect TRANSPORT: usb, local, or any [default=any] TRANSPORT: usb, local,  or  any [default=any] get-state print offline | bootloader | device get-state  print  offline  |  bootloader  |  device get-serialno print <serial-number> get-serialno  print <serial-numbe r> get-devpath print <device-path> get-devpath  print <device-pat h> remount [-R]  remount [-R] remount partitions read-write. if a reboot is required, -R will  remount  partitions read-write.  if  a  reboot  is required, -R  will will automatically reboot the device.  will  automatically  reboot  the device. reboot [bootloader|recovery|sideload|sideload-auto-reboot]  reboot [bootloader | recovery | sideload |sideload-auto-reboot] reboot the device; defaults to booting system image but  reboot  the  device; defaults  to  booting  system  image  but supports bootloader and recovery too. sideload reboots  supports  bootloader  and  recovery too.  sideload  reboots into recovery and automatically starts sideload mode,  into  recovery  and  automatically  starts  sideload mode, sideload-auto-reboot is the same but reboots after sideloading. sideload-auto-reboot  is  the  same  but  reboots  after sideloading.  sideload OTAPACKAGE sideload the given full OTA package  sideload  OTAPACKAGE  sideload  the  given  full  OTA  package  root restart adbd with root permissions  root  restart  adbd  with  root  permissions  unroot restart adbd without root permissions  unroot  restart  adbd  without  root  permissions  usb restart adbd listening on USB  usb  restart  adbd  listening  on  USB  tcpip PORT restart adbd listening on TCP on PORT  tcpip  PORT  restart  adbd  listening  on  TCP  on  PORTinternal debugging: internal debugging: start-server ensure that there is a server running start-server  ensure  that  there  is  a  server  running kill-server kill the server if it is running kill-server  kill  the  server  if  it  is  running  reconnect kick connection from host side to force reconnect  reconnect  kick  connection  from  host  side  to  force  reconnect  reconnect device kick connection from device side to force reconnect  reconnect  device  kick  connection  from  device  side  to  force  reconnect reconnect offline reset offline/unauthorized devices to force reconnect  reconnect  offline  reset offline/unauthorized  devices  to  force  reconnectusb:usb:  attach attach a detached USB device  attach  attach  a  detached  USB  device  detach detach from a USB device to allow use by other processes  detach  detach  from  a  USB  device  to  allow  use  by  other  processesenvironment variables:$ADB_TRACE environment variables: $ADB_TRACE comma-separated list of debug info to log: comma-separated  list  of  debug  info  to log: all,adb,sockets,packets,rwx,usb,sync,sysdeps,transport,jdwp$ADB_VENDOR_KEYS colon-separated list of keys (files or directories)$ANDROID_SERIAL serial number to connect to (see -s)$ANDROID_LOG_TAGS tags to be used by logcat (see logcat --help)$ADB_LOCAL_TRANSPORT_MAX_PORT max emulator scan port (default 5585, 16 emus)$ADB_MDNS_AUTO_CONNECT comma-separated list of mdns services to allow auto-connect (default adb-tls-connect) all,adb,sockets,packets,rwx,usb,sync,sysdeps,transport,jdwp$ADB_VENDOR_KEYS colon-separated  list  of  keys (files or  directories)$ANDROID_SERIAL serial number to connect to (see -s)$ANDROID_LOG_TAGS tags to be used by logcat (see  logcat --help)$ADB_LOCAL_TRANSPORT_MAX_PORT max emulator scan port (default 5585,  16  emus)$ADB_MDNS_AUTO_CONNECT comma-separated list of mdns services to allow auto-connect (default adb-tls-connect)Online documentation: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md Online documentation: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/master/docs/user/adb.1.md
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
27  
28  
29  
30  
31  
32  
33  
34  
35  
36  
37  
38  
39  
40  
41  
42  
43  
44  
45  
46  
47  
48  
49  
50  
51  
52  
53  
54  
55  
56  
57  
58  
59  
60  
61  
62  
63  
64  
65  
66  
67  
68  
69  
70  
71  
72  
73  
74  
75  
76  
77  
78  
79  
80  
81  
82  
83  
84  
85  
86  
87  
88  
89  
90  
91  
92  
93  
94  
95  
96  
97  
98  
99  
100  
101  
102  
103  
104  
105  
106  
107  
108  
109  
110  
111  
112  
113  
114  
115  
116  
117  
118  
119  
120  
121  
122  
123  
124  
125  
126  
127  
128  
129  
130  
131  
132  
133  
134  
135  
136  
137  
138  
139  
140  
141  
142  
143  
144  
145  
146

### 列出已连接的设备列表 [​](#列出已连接的设备列表)

shell

```
adb devices adb  devices
```

案例：打开命令行窗口运行以下命令

shell

```
C:\Users\win>adb devicesC:\Users\win> adb  devices List of devices attached List  of  devices  attached 4d70015485fe537b device 4d70015485fe537b  device 4d70015485fe537b device 4d70015485fe537b  device
```

1  
2  
3  
4

### 启动设备的命令行 [​](#启动设备的命令行)

* 进入命令

shell

```
adb shell adb  shell
```

1

* 命令说明： 连接到设备的 shell，你可以在命令行中直接输入命令，并且设备会执行这些命令。例如，你可以运行常见的 Linux 命令、执行设备特定命令，或使用各种adb工具提供的功能。

shell

```
#进入设备 #进入设备 adb shell adb  shell #使用root权限 #使用root权限 su su#在泰山中使用ls命令ls#在泰山派中使用pwd查看路径pwd#查看泰山派kernel日志-----非常重要-------#在泰山中使用ls命令ls#在泰山派中使用pwd查看路径pwd#查看泰山派kernel日志-----非常重要------- dmesg dmesg#查看系统层日志-----非常重要-------#查看系统层日志-----非常重要------- logcat logcat
```

1  
2  
3  
4  
5  
6  
7  
8

* 演示案例：

- 退出命令

shell

```
exit exit
```

1

shell

```
adb install adb  install
```

1

shell

```
C:\Users\win>adb install C:\Users\win\Downloads\chrome.apkC:\Users\win> adb  install C: \U sers \w in \D ownloads \chrome.apk Performing Streamed Install Performing  Streamed  Install Success Success
```

1  
2  
3

同时我们也可以通过命令来查看是否安装成功，其中"adb shell pm list packages"命令使列出所有包并且通过grep 过滤出包含"chrome"关键字的包，如果想查看全部可以不加 "| grep chrome"

shell

```
C:\Users\win>adb shell pm list packages | grep chromeC:\Users\win> adb  shell  pm  list  packages  |  grep  chromepackage:com.android.chromepackage:com.android.chrome
```

1  
2

### 卸载应用程序 [​](#卸载应用程序)

shell

```
adb uninstall adb  uninstall
```

1

shell

```
C:\Users\win>adb shell pm list packagesC:\Users\win> adb  shell  pm  list  packagespackage:com.android.cts.priv.ctsshimpackage:com.android.cts.priv.ctsshimpackage:com.android.keychainpackage:com.android.keychainpackage:com.android.chromepackage:com.android.chrome 以下省略N行 以下省略N行
```

1  
2  
3  
4  
5

shell

```
C:\Users\win>adb uninstall com.android.chromeC:\Users\win> adb  uninstall com.android.chrome Success Success
```

1  
2  
3

### 将文件从电脑复制到设备 [​](#将文件从电脑复制到设备)

shell

```
adb push adb  push
```

1

在使用"adb push"命令将文件推送到 Android 设备之前，有时需要先执行 remount 操作，以便将设备的文件系统以可写模式挂载。默认情况下，Android 设备的文件系统通常以只读模式挂载，这是为了保护系统的完整性和安全性。这意味着你无法直接向设备的文件系统写入文件或修改系统文件。通过执行 remount 操作，可以将文件系统从只读模式切换为可写模式，允许向设备的文件系统写入文件或修改系统文件。因为执行remount需要root权限所有先执行root在执行remount

shell

```
 #执行root #执行rootC:\Users\win>adb rootC:\Users\win> adb  root restarting adbd as root restarting  adbd  as  root #执行romout #执行romoutC:\Users\win>adb remountC:\Users\win> adb  remountUsing overlayfs for /system Using  overlayfs  for /systemUsing overlayfs for /vendor Using  overlayfs  for /vendorUsing overlayfs for /odm Using  overlayfs  for /odmUsing overlayfs for /product Using  overlayfs  for /productUsing overlayfs for /system_ext Using  overlayfs  for /system_ext Now reboot your device for settings to take effect Now  reboot  your  device  for  settings  to  take  effect remount succeeded remount  succeeded
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

"adb push 文件目录 开发板中的目录"

shell

```
C:\Users\win>adb push C:\Users\win\Downloads\chrome.apk /dataC:\Users\win> adb  push C: \U sers \w in \D ownloads \chrome.apk /dataC:\Users\win\Downloads\chrome.apk: 1 file pushed, 0 skipped. 48.3 MB/s (236058891 bytesin4.661s)C:\Users\win\Downloads\chrome.apk:  1  file pushed,  0 skipped. 48.3 MB/s (236058891 bytesin4.661s) #进入查看是否成功 #进入查看是否成功C:\Users\win>adb shellC:\Users\win> adb  shellrk3566_tspi:/# ls /data/crk3566_tspi:/#  ls /data/ccache/ chrome.apk#发现一直存在目录里了cache/ chrome.apk#发现一直存在目录里了
```

1  
2  
3  
4  
5  
6

### 将文件从设备复制到电脑 [​](#将文件从设备复制到电脑)

shell

```
adb pull adb  pull
```

1

"adb pull 开发板中的目录 文件保存目录"

shell

```
#在泰山派开发板中创建一个测试文件 #在泰山派开发板中创建一个测试文件rk3566_tspi:/data# echo "tispi" > pulldemo.txt#退出shell终端rk3566_tspi:/data#  echo  "tispi" > pulldemo.txt#退出shell终端rk3566_tspi:/data# exit#这里正式开始测试，我们把刚刚在/data/文件夹下的创建的pulldemo.txt复制到电脑C:\Users\win\Downloads中rk3566_tspi:/data# exit#这里正式开始测试，我们把刚刚在/data/文件夹下的创建的pulldemo.txt复制到电脑C: \U sers \w in \D ownloads中C:\Users\win>adb pull /data/pulldemo.txt C:\Users\win\DownloadsC:\Users\win> adb  pull /data/pulldemo.txt C: \U sers \w in \D ownloads #提示传输速率时间等，表示成功 #提示传输速率时间等，表示成功/data/pulldemo.txt: 1 file pulled, 0 skipped. 0.0 MB/s (6 bytesin0.002s)/data/pulldemo.txt:  1  file pulled,  0 skipped. 0.0 MB/s (6 bytesin0.002s)
```

1  
2  
3  
4  
5  
6

### 查看设备的日志信息 [​](#查看设备的日志信息)

* logcat简单理解为负责Android层日志输出

shell

```
adb logcat adb  logcat
```

1

* dmesg简单理解为负责Linux层日志输出

shell

```
adb dmesg adb  dmesg
```

1

### 进入升级模式 [​](#进入升级模式)

shell

```
adb reboot loader adb  reboot  loader
```

1

 



