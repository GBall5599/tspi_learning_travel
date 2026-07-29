# 2026-07-29 学习应用记录：同名 SSID、BSSID 与跨网段 Wi-Fi 排障

## 一、应用目标

1. 将开发板 Wi-Fi 从旧环境切换到 `rskj`；
2. 解决电脑与开发板连接同名 Wi-Fi 却不在同一网段的问题；
3. 理解 SSID、BSSID、频段、DHCP、网关和子网之间的关系；
4. 验证指定 BSSID 后的自动联网、重启持久化与 SSH 可达性。

## 二、环境信息

```text
板卡：LCKFB-TSPI-RK3566-2G-16G
系统：Buildroot 2024.02
内核：Linux 6.1.141 aarch64
串口：COM10 @ 1500000，8N1，无流控
Wi-Fi SSID：rskj
电脑 Wi-Fi：192.168.30.136/24
电脑默认网关：192.168.30.1
开发板最终 IP：192.168.30.227/24
开发板最终网关：192.168.30.1
开发板最终 BSSID：DC:D8:7C:57:74:D4（2.4 GHz，Channel 1）
SSH：Dropbear，TCP 22
```

> Wi-Fi 密码不写入学习记录。

## 三、问题现象

修改 `/etc/wpa_supplicant.conf` 并启动 `/etc/init.d/S45wifi-auto` 后，开发板获得：

```text
开发板 IP：192.192.192.139/24
默认网关：192.192.192.192
SSID：rskj
BSSID：DC:D8:7C:28:64:36
```

电脑同时连接 `rskj`，但处于：

```text
电脑 IP：192.168.30.136/24
默认网关：192.168.30.1
5 GHz BSSID：DC:D8:7C:57:74:D3
```

两端虽然显示相同 SSID，却分别位于 `192.192.192.0/24` 和 `192.168.30.0/24`，电脑无法直接访问开发板。

## 四、排障过程

### 1. 确认开发板已关联无线 AP

```sh
iwconfig wlan0
```

结果显示开发板已经关联 `rskj`，信号约 `-67 dBm`，但接入点为：

```text
DC:D8:7C:28:64:36
```

这说明问题不在“完全没有连接 Wi-Fi”，而需要继续检查 DHCP 和网络拓扑。

### 2. 检查地址和路由

```sh
ip -4 addr show wlan0
ip route
```

结果：

```text
192.192.192.139/24
默认网关 192.192.192.192
```

### 3. 验证网关是否真实存在

```sh
ping -c 3 192.192.192.192
```

结果 3/3 成功，说明该地址和路由不是单纯的旧配置残留。

继续检查邻居表：

```sh
ip neigh show 192.192.192.192
```

得到：

```text
192.192.192.192 dev wlan0 lladdr dc:d8:7c:28:64:34 REACHABLE
```

AP `DC:D8:7C:28:64:36` 与网关 `DC:D8:7C:28:64:34` 的 MAC 地址高度相近，可以判断它们属于同一台路由器或中继设备。

### 4. 对比电脑侧主路由器

电脑侧确认：

```text
5 GHz AP：DC:D8:7C:57:74:D3
网关 MAC：DC:D8:7C:57:74:D1
```

这与开发板最初连接的 `DC:D8:7C:28:64:xx` 明显是两台不同设备。

### 5. 扫描同名 SSID 的全部 AP

```sh
iwlist wlan0 scanning | grep -E 'Cell |ESSID:|Frequency:|Quality='
```

扫描到至少三个名为 `rskj` 的 BSSID，其中关键结果为：

```text
DC:D8:7C:28:64:36  rskj  2.437 GHz / Channel 6
C0:A5:DD:CC:4C:35  rskj
DC:D8:7C:57:74:D4  rskj  2.412 GHz / Channel 1
```

`DC:D8:7C:57:74:D4` 与电脑的主路由器网关 `...:D1`、5 GHz AP `...:D3` 属于同一组设备，因此确定它是目标 2.4 GHz AP。

## 五、根因分析

本次问题的根因不是开发板随机生成错误 IP，而是：

1. 环境中有多个 AP 广播相同 SSID `rskj`；
2. 不同 AP 背后连接的并不是同一个二层局域网或 DHCP 服务；
3. 原配置只指定 `ssid` 和 `psk`，没有限制 BSSID；
4. 开发板仅使用 2.4 GHz，会从多个同名 AP 中自动选择候选；
5. 开发板最初选择了 `DC:D8:7C:28:64:36`，由该设备真实分配了 `192.192.192.x`；
6. 电脑连接主路由器的 5 GHz AP，因此获得 `192.168.30.x`，两端无法直接互通。

`192.192.192.0/24` 不是 RFC 1918 私有地址范围。如果该设备属于可管理的内部路由器，后续应考虑调整其 LAN 地址和工作模式。

## 六、修复方法

### 1. 备份配置

```sh
cp -a /etc/wpa_supplicant.conf /etc/wpa_supplicant.conf.bak-20260729
```

### 2. 在目标网络块中锁定 BSSID

编辑：

```sh
vi /etc/wpa_supplicant.conf
```

配置结构：

```text
network={
    ssid="rskj"
    psk="不记录真实密码"
    bssid=DC:D8:7C:57:74:D4
}
```

本次编辑中曾将 `bssid` 误写为 `bassid`，`wpa_supplicant` 报错：

```text
unknown network field 'bassid'
failed to parse network block
```

修正命令：

```sh
sed -i 's/bassid=/bssid=/' /etc/wpa_supplicant.conf
```

这说明配置字段必须准确拼写；一处未知字段会导致整个 `network` 块解析失败。

### 3. 清理旧连接并重新启动

```sh
sync
killall udhcpc 2>/dev/null
killall wpa_supplicant 2>/dev/null
ip -4 addr flush dev wlan0
ip route flush dev wlan0
/etc/init.d/S45wifi-auto start
```

## 七、最终验证

### 1. 无线关联

```sh
iwconfig wlan0
```

重启后仍显示：

```text
ESSID:"rskj"
Frequency:2.412 GHz
Access Point: DC:D8:7C:57:74:D4
Signal level:-70 dBm
```

### 2. IPv4 和路由

```sh
ip -4 addr show wlan0
ip route
```

结果：

```text
开发板 IP：192.168.30.227/24
默认网关：192.168.30.1
直连网段：192.168.30.0/24
```

### 3. 电脑与 SSH

电脑到开发板 Ping 复测：

```text
5 次发送，5 次接收，0% 丢包
```

开发板确认 Dropbear：

```sh
netstat -an | grep ':22'
```

结果：

```text
0.0.0.0:22 LISTEN
:::22 LISTEN
```

电脑侧 TCP 22 测试成功，可使用：

```powershell
ssh root@192.168.30.227
```

### 4. 重启持久化

执行 `sync`、`reboot` 后，BSSID、IPv4 地址、默认网关和 SSH 服务均恢复正常，说明 `/etc/wpa_supplicant.conf` 与 `S45wifi-auto` 的开机流程生效。

## 八、本次掌握的知识点

- SSID 是无线网络名称，BSSID 是具体 AP 无线接口的 MAC 地址；
- 相同 SSID 不保证背后一定是同一个局域网；
- 电脑可连接 5 GHz，而 AP6212A 开发板主要使用 2.4 GHz；
- DHCP 分配结果由实际连接的 AP/路由网络决定；
- `/24` 子网不同且没有路由时，两个客户端不能直接通信；
- `ip route` 用于判断默认网关，`ip neigh` 用于查看网关对应的 MAC；
- `bssid=` 可以锁定目标 AP，但会失去自动漫游到其他 BSSID 的能力；
- `wpa_supplicant` 配置字段拼写错误会导致整个网络块加载失败；
- 先通过串口排障，再验证 Ping、TCP 22、SSH 和重启持久化。

## 九、后续改进建议

1. 当前保留 `bssid=DC:D8:7C:57:74:D4`，保证开发板进入 `192.168.30.0/24`；
2. 如果可管理 `DC:D8:7C:28:64:xx` 设备，建议改为 AP/桥接模式并关闭独立 DHCP；
3. 如果必须保留不同子网，应为不同网络使用不同 SSID，避免客户端误选；
4. 后续可增强 `/etc/init.d/S45wifi-auto`：申请 DHCP 前主动清理旧 IPv4 地址和路由，并避免仅凭“接口已有 inet 地址”判断 DHCP 成功；
5. 当前正确 AP 信号约 `-70 dBm`，长期使用时可调整开发板、天线或路由器位置。

## 十、本次结论

```text
同名 SSID 不等于同一个局域网。
先用 BSSID 确认实际 AP，再结合 IP、路由、网关 MAC 和 DHCP 结果定位网络路径。
本次通过锁定主路由器 2.4 GHz BSSID，开发板成功回到 192.168.30.0/24，并完成重启和 SSH 验证。
```