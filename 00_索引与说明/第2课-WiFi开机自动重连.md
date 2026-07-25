# 第 2 课：Wi-Fi 开机自动重连

> 状态：✅ 已完成（2026-07-24）  
> 目标：重启后不用手工再连 Wi-Fi，SSH 仍能登录。  
> 前提：已会手动 `wifi-connect.sh` + `udhcpc`，并理解 `/tmp` 不持久。

---

## 1. 为什么重启后 Wi-Fi 会掉？

你已经验证过：

```text
手动连接成功
  → 能拿到 IP
  → 能 SSH

重启后
  → wlan0 可能还在，甚至 UP
  → 但 NO-CARRIER / 没有 inet
  → SSH 连不上
```

原因：

```text
wifi-connect.sh 把配置写到了 /tmp/wpa_supplicant.conf
/tmp 是临时区域，重启会丢
所以热点账号密码没有被长期保存
```

所以：

```text
连上一次  ≠  开机自动连
```

---

## 2. 本课要做成什么

重启后自动完成：

```text
1. 启动 wpa_supplicant（带持久配置）
2. 关联 ccccc2.4g
3. DHCP 获取 IP
4. 电脑仍可用 ssh root@新IP 登录
```

注意：IP 仍可能从 `.105` 变成 `.106`，除非后面再做固定 IP/查找方式。  
本课先解决“自动连上 Wi-Fi”。

---

## 3. 本课操作原则

- 先在 SSH 或串口里操作都可以，但**改网络时串口更安全**
- 不要把 Wi-Fi 密码发到聊天里
- 每做一步，先想：这一步在解决哪一层？

---

## 4. 实操步骤（已完成）

### 步骤 A：确认当前手动网络是好的

```bash
ip -4 addr show wlan0
ping -c 2 192.168.0.1
```

### 步骤 B：查看现有配置从哪来

```bash
ls -l /etc/wpa_supplicant.conf /tmp/wpa_supplicant.conf 2>/dev/null
cat /etc/wpa_supplicant.conf
```

### 步骤 C：把 Wi-Fi 配置写到持久位置

把 SSID/密码写进：

```text
/etc/wpa_supplicant.conf
```

或写到 `/userdata` 再软链接/拷贝到 `/etc`（更稳妥的一种做法）。

### 步骤 D：写一个开机启动脚本

在 `/etc/init.d/` 增加或修改启动项，让开机后自动：

```text
wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf
udhcpc -i wlan0 -n -q
```

### 步骤 E：reboot 验证

```bash
sync
reboot
```

重启后检查：

1. 串口能否进系统
2. `wlan0` 是否有 `inet`
3. 电脑能否重新 SSH

---

## 5. 成功标准

- [x] 重启后无需手工 `wifi-connect.sh`
- [x] `wlan0` 自动获得 IPv4
- [x] 能 ping 通网关
- [x] 电脑能 SSH 登录（IP 可能变化）

---

## 6. 课前概念题（已完成）

开始动手前，先确认概念：

```text
为什么要把 Wi-Fi 配置写到 /etc 或 /userdata，
而不是继续写在 /tmp？
```

本题已在实操前回答，并据此完成了后续配置。

## 7. 2026-07-24 完成记录

实际完成：

1. 将有效配置从 `/tmp/wpa_supplicant.conf` 持久化到 `/etc/wpa_supplicant.conf`。
2. 创建 `/etc/init.d/S45wifi-auto`。
3. 手动运行脚本，验证 Wi-Fi 认证、DHCP 和网关 Ping。
4. `reboot` 后日志出现 `wifi-auto: OK`。
5. 重启后获得 `192.168.0.106/24`，并通过 SSH 登录成功。

详细学习记录：`学习记录/2026-07-24-第2课学习记录.md`。

注意：本课完成的是“开机自动连接”；实际切换到另一个热点的操作流程已理解，但今天没有改变当前热点配置。


---

## 8. 2026-07-25 更换环境后的复测

本课原先在 Wi-Fi `ccccc2.4g` 环境完成。2026-07-25 更换网络环境后，使用同一套持久化机制重新验证：

```text
新 SSID：ChinaNet-gsZY
最终 IP：192.168.1.8/24
网关：192.168.1.1
```

复测过程：

1. 备份 `/etc/wpa_supplicant.conf`；
2. 用 `vi` 修改 `ssid` 和 `psk`；
3. 执行 `sync`；
4. 停止旧的 `wpa_supplicant` 和 `udhcpc`；
5. 执行 `/etc/init.d/S45wifi-auto start`；
6. 将开发板移近路由器后获得 `192.168.1.8`；
7. Ping 网关 3/3 成功；
8. MobaXterm SSH 登录成功；
9. `reboot` 后自动联网并再次 SSH 登录成功。

这说明 `S45wifi-auto` 不是只适用于某一个旧 SSID，而是可以配合新的 `/etc/wpa_supplicant.conf` 工作。

注意：切换 Wi-Fi 时优先使用串口，因为 SSH 会因网络切换而断开。
