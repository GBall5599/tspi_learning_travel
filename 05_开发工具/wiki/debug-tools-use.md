<!--
source: https://wiki.lckfb.com/zh-hans/tspi-rk3566/tool-use/debug-tools-use.html
retrieved_at: 2026-07-19 15:13:32 +08:00
category: tool
-->
[Skip to content](#VPContent)


[![](../../assets/wiki.lckfb.com/storage/logo/logo_cn_dark.svg)![](../../assets/wiki.lckfb.com/storage/logo/logo_cn_light.svg)](/zh-hans/)

简体中文

[English](/en/tspi-rk3566/tool-use/debug-tools-use.html)

# [​](#【立创·泰山派rk3566开发板】调试工具使用教程)

## 文档更新说明 [​](#文档更新说明)

## 免责声明 [​](#免责声明)

本文档虽力求准确，但可能存在错误或遗漏，用户需谨慎评估适用性；我们保留随时修订的权利，且不保证旧版本内容的有效性，为了得到最新版本的产品信息，请定时访问立创开发板官网进行资料的更新下载。本文档版权及最终解释权归深圳嘉立创科技集团股份有限公司所有。请务必注意以上声明，自行评估风险并决策，我们对使用本文档产生的任何问题概不负责。感谢您的包容与支持。

## 一、Electerm [​](#一、electerm)

我们在平时开发的时候会经常用到终端工具，如通过ssh连接我们的虚拟机，又如使用串口连接开发板通打印日志与输入调试命令等，所以一款趁手的工具可以大大的提高我们的生产效率。这里给大家推荐一款开源工具electerm

开源地址：<https://github.com/electerm/electerm>  
 Git下载地址：<https://github.com/electerm/electerm/releases>  
 官网下载地址：<https://electerm.html5beta.com/>

### 1. 下载 [​](#_1-下载)

这里以在win10中安装为例，打开Git下载地址：<https://github.com/electerm/electerm/releases>  
 选择下载 `electerm-1.28.4-win-x64-installer.exe`

双击点击安装，然后一直下一步

使用electerm连接虚拟机需要确保虚拟中已经安装并启动了ssh服务

#### 1.1 虚拟机安装ssh服务 [​](#_1-1-虚拟机安装ssh服务)

已经安装的可以跳过

安装ssh服务

shell

```
apt-get updateapt-get  update sudo apt-get install openssh-client sudo apt-get  install openssh-clientsudo apt-get install openssh-server sudo apt-get  install openssh-server
```

1  
2  
3  
4

启动ssh服务

shell

```
/etc/init.d/ssh start/etc/init.d/ssh  start #显然如下表示启动正常 #显然如下表示启动正常[ ok ] Starting ssh (via systemctl): ssh.service.[ ok ] Starting ssh (via  systemctl): ssh.service.
```

1  
2  
3

查看是否安装成功

shell

```
sudo ps -e | grep ssh sudo  ps -e  |  grep  ssh
```

1

查看ip地址

shell

```
root@wucaicheng-virtual-machine:/home/wucaicheng# ifconfigroot@wucaicheng-virtual-machine:/home/wucaicheng#  ifconfigens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST> mtu 1500ens33: flags= 4163<UP,BROADCAST,RUNNING,MULTICAS T>  mtu  1500 inet 192.168.20.129 netmask 255.255.255.0 broadcast 192.168.20.255  inet 192.168.20.129  netmask 255.255.255.0  broadcast 192.168.20.255 inet6 fe80::dfc7:1050:ebe5:632c prefixlen 64 scopeid 0x20<link>  inet6 fe80::dfc7:1050:ebe5:632c  prefixlen  64  scopeid  0x20< lin k> ether 00:0c:29:e6:57:8a txqueuelen 1000 (Ethernet)  ether 00:0c:29:e6:57:8a  txqueuelen  1000 (Ethernet) RX packets 21658081 bytes 32767560390 (32.7 GB)  RX  packets  21658081  bytes  32767560390 (32.7 GB)  RX errors 21125 dropped 21141 overruns 0 frame 0  RX  errors  21125  dropped  21141  overruns  0  frame  0 TX packets 1771567 bytes 102577817 (102.5 MB)  TX  packets  1771567  bytes  102577817 (102.5 MB)  TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0  TX  errors  0  dropped  0  overruns  0  carrier  0  collisions  0  device interrupt 19 base 0x2000  device  interrupt  19  base  0x2000 lo: flags=73<UP,LOOPBACK,RUNNING> mtu 65536lo: flags= 73<UP,LOOPBACK,RUNNIN G>  mtu  65536 inet 127.0.0.1 netmask 255.0.0.0  inet 127.0.0.1  netmask 255.0.0.0 inet6 ::1 prefixlen 128 scopeid 0x10<host>  inet6 ::1  prefixlen  128  scopeid  0x10< hos t> loop txqueuelen 1000 (Local Loopback)  loop  txqueuelen  1000 (Local Loopback) RX packets 659 bytes 92550 (92.5 KB)  RX  packets  659  bytes  92550 (92.5 KB)  RX errors 0 dropped 0 overruns 0 frame 0  RX  errors  0  dropped  0  overruns  0  frame  0 TX packets 659 bytes 92550 (92.5 KB)  TX  packets  659  bytes  92550 (92.5 KB)  TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0  TX  errors  0  dropped  0  overruns  0  carrier  0  collisions  0
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

#### 1.2 新建ssh连接 [​](#_1-2-新建ssh连接)

1. 添加连接

1. 输入你要连接对象的ip地址，但是对方必须启动了ssh服务
2. 输入用户名
3. 输入用户名密码
4. 其他保持默认，下拉到后进行测试并连接。

ssh连接成功

这里需要注意，被连接对象必须启动ssh服务，并且保证你在win10上能够成功ping通对方ip，如果无法ping通过，可以检查是否在同一局域网，是否被防火墙拦截等。

### 2. 串口终端使用 [​](#_2-串口终端使用)

#### 2.1 串口调试必备 [​](#_2-1-串口调试必备)

WARNING

📌 注意：大家可以看看自己的USB转串口的模块是否支持波特率**1500000**或更高，因为泰山派的串口波特率是**1500000**，所以请悉知!!

如果您有天空星开发板，那么恭喜您则可以直接使用天空星开发板作为USB转串口的工具，完美支持泰山派串口调试。

[天空星GD32-DAPLink教程（点击跳转🚀）](/zh-hans/tkx/tkx-gd32f407vet6/daplink-bare/daplink-bare.html)

串口连接的方式对于我们来说比较方便，而在泰山派开发板中也为我们预留了**Debug接口。**

此接口是 **GH1.25 4P** 的端子接口，4P它们分别是：**GND、TX、RX和VCC**

所以我们需要购买 **GH1.25 4P的端子线（单头）** 可以去淘宝直接搜索购买，因为单头线的另一端可以连接杜邦线，让我们省去一些麻烦。

> [点击跳转🚀](https://item.taobao.com/item.htm?abbucket=15&id=620275448420&ns=1&skuId=4384278648274&spm=a21n57.1.0.0.5564523ctne3Mm)

> 注意：此店铺和立创并无任何合作，请选择购买。

制作方法是下方图片的样子：

估计看到这里有很多人会有疑惑，端子明明有**4个引脚**，为什么连接的杜邦线只有**三个引脚**。

因为我们在设计泰山派的时候将**Debug调试端口的VCC直接和5V连接**在一起了，所以我们就不需要连接VCC电源线了，只需要TX、RX和GND线。

我们将**端子一侧插入泰山派Debug调试串口**，另一端的**三根杜邦线连接USB转串口模块**。  
 这样我们的串口调试必备的前期工作就完成了。

#### 2.2 软件使用 [​](#_2-2-软件使用)

1. 新建连接
2. 选择串口连接
3. 这里选择自己虚拟串口端口，我这是COM33
4. 选择波特率，如果波特率不对会乱码或者无法显示，我们泰山派开发板对应的波特率是**1500000** 。

成功打印日志

## 二、MoBaXterm [​](#二、mobaxterm)

WARNING

📌 官方下载地址：<https://mobaxterm.mobatek.net/download.html>

至于中文版本的下载，可以自己去网上搜索，网上有很多教程。

### 1. 串口调试 [​](#_1-串口调试)

#### 1.1 串口调试必备 [​](#_1-1-串口调试必备)

📌 注意：大家可以看看自己的USB转串口的模块是否支持波特率**1500000**或更高，因为泰山派的串口波特率是**1500000**，所以请悉知!!

如果您有天空星开发板，那么恭喜您则可以直接使用天空星开发板作为USB转串口的工具，完美支持泰山派串口调试。

[天空星GD32-DAPLink教程（点击跳转🚀）](/zh-hans/tkx/tkx-gd32f407vet6/daplink-bare/daplink-bare.html)

串口连接的方式对于我们来说比较方便，而在泰山派开发板中也为我们预留了**Debug接口**。

此接口是 **GH1.25 4P** 的端子接口，4P它们分别是：**GND、TX、RX和VCC** 。

所以我们需要购买 **GH1.25 4P的端子线（单头）** 可以去淘宝直接搜索购买，因为单头线的另一端可以连接杜邦线，让我们省去一些麻烦。

> [点击跳转🚀](https://item.taobao.com/item.htm?abbucket=15&id=620275448420&ns=1&skuId=4384278648274&spm=a21n57.1.0.0.5564523ctne3Mm)



制作方法是下方图片的样子：

估计看到这里有很多人会有疑惑，端子明明有**4个引脚**，为什么连接的杜邦线只有**三个引脚**。

因为我们在设计泰山派的时候将 **Debug调试端口的VCC直接和5V连接** 在一起了，所以我们就不需要连接VCC电源线了，只需要TX、RX和GND线。

我们将**端子一侧插入泰山派Debug调试串口**，另一端的**三根杜邦线连接USB转串口模块**。

#### 1.2 软件使用 [​](#_1-2-软件使用)

点击会话，然后点击`Serial`。

选择`COM`串口号，这里我的是`COM29`。

我们点击波特率直接输出：**1500000** （注意不要点击右边的下拉，在选项中没有**1500000**，所以直接输入就好）

我们点击 **settings** 进行设置（按照下图的设定来）：

### 2. SSH [​](#_2-ssh)

#### 2.1 前言 [​](#_2-1-前言)

SSH是一种非常常用的远程调试方式，泰山派开发板拥有众多的网络连接方式，包括但不限于：**USB共享网络、扩展版网线连接和WIFI连接等**。。。

#### 2.2 SSH安装 [​](#_2-2-ssh安装)

WARNING

📌 注意：SSH安装要在有网络的环境下进行

shell

```
sudo apt-get update sudo apt-get  update
```

1

shell

```
sudo apt-get install openssh-client sudo apt-get  install openssh-client
```

1

shell

```
sudo apt-get install openssh-server sudo apt-get  install openssh-server
```

1

shell

```
ps -e|grep ssh ps -e | grep  ssh
```

1

如果出现了 **sshd** 和 **ssh-agent** 那就说明服务器和客户端都已经启动完成了。

如果缺少 sshd ，说明ssh服务没有启动或者没有安装。

如果缺少 ssh-agent，且已经安装成功了，则可以使用下方的命令：

shell

```
eval ssh-agent eval ssh-agent
```

1

然后再检查，就会发现缺失的 ssh-agent 出现了。

#### 2.3 SSH文件配置 [​](#_2-3-ssh文件配置)

使用以下命令打开 **sshd\_config** 文件

shell

```
vim /etc/ssh/sshd_config vim /etc/ssh/sshd_config
```

1

将 `Port` 前方的 `#` 删掉，然后改一个自己想要的端口号，建议端口号不要小于6000！

> 这里我们修改为 8080 端口。  
>  默认端口号是：22  
>  不修改端口号则系统会使用默认端口号。

打开文件后找到这个位置，将箭头指示的语句开头的 `#` 删掉。

完成修改之后我们输入命令重启ssh，这样配置就生效了。

shell

```
sudo /etc/init.d/ssh restart sudo /etc/init.d/ssh  restart
```

1

#### 2.4 查看IP地址 [​](#_2-4-查看ip地址)

shell

```
sudo ifconfig sudo  ifconfig
```

1

只有 usb0 是拥有inet这个选项的，上面的IP为：192.168.137.190 （我们记住这个IP，这个IP是用来远程登录SSH用的）

> * 根据你的连接方式不同，所拥有网络的接口也不同，我使用的是USB共享网络所以本机显示的是 usb0 这个网络端口。
> * lo这个网络端口的IP是：127.0.0.1 这个地址是本机回环地址，不具备对外网络连接的功能，只可用于本机调试使用。关于回环地址可以从网络上搜到的大量的资料。

#### 2.5 软件使用 [​](#_2-5-软件使用)




我们输入用户名：**root** 然后按下回车

 



