# 第2课补丁：不用 cat  heredoc 的写法

SSH 里 `cat <<EOF` 容易失败，改用下面两种稳妥方法。

---

## 方法 A（推荐，最简单）

你的 `/etc/wpa_supplicant.conf` 本来就是模板：

```text
ssid="SSID"
psk="PASSWORD"
```

直接替换占位符即可。

在 SSH 中执行（把 `你的密码` 换成真实密码，**不要发给我**）：

```bash
cp -a /etc/wpa_supplicant.conf /etc/wpa_supplicant.conf.bak

sed -i 's/ssid="SSID"/ssid="ccccc2.4g"/' /etc/wpa_supplicant.conf
sed -i 's/psk="PASSWORD"/psk="你的密码"/' /etc/wpa_supplicant.conf

# 检查时把密码打码
sed 's/psk=.*/psk="******"/' /etc/wpa_supplicant.conf
```

如果密码里有特殊字符（`/` `'` `"` `&` 等），用方法 B。

---

## 方法 B：先手动连一次，再把 /tmp 配置拷到 /etc

```bash
# 1. 先按以前方式连上（密码自己填，不发我）
wifi-connect.sh ccccc2.4g '你的密码'

# 2. 确认连上了
ip -4 addr show wlan0
# 如果没有 inet，再执行：
udhcpc -i wlan0 -n -q
ip -4 addr show wlan0

# 3. 把临时配置拷成持久配置
cp -a /tmp/wpa_supplicant.conf /etc/wpa_supplicant.conf

# 4. 打码检查
sed 's/psk=.*/psk="******"/' /etc/wpa_supplicant.conf
```

这一步的本质：

```text
/tmp 里已经有正确配置
拷到 /etc 后，重启也还在
```

---

## 方法 C：用 printf 一行行写（不用 heredoc）

```bash
cp -a /etc/wpa_supplicant.conf /etc/wpa_supplicant.conf.bak

printf '%s\n' \
'ctrl_interface=/var/run/wpa_supplicant' \
'ap_scan=1' \
'update_config=1' \
'network={' \
'    ssid="ccccc2.4g"' \
'    psk="你的密码"' \
'    key_mgmt=WPA-PSK' \
'}' > /etc/wpa_supplicant.conf

sed 's/psk=.*/psk="******"/' /etc/wpa_supplicant.conf
```

---

## 写好配置后，创建开机脚本（也不用 heredoc）

逐条执行：

```bash
printf '%s\n' '#!/bin/sh' > /etc/init.d/S45wifi-auto
printf '%s\n' 'WPA_CONF=/etc/wpa_supplicant.conf' >> /etc/init.d/S45wifi-auto
printf '%s\n' 'IFACE=wlan0' >> /etc/init.d/S45wifi-auto
printf '%s\n' 'start() {' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  printf "Starting wifi-auto: "' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  i=0' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  while [ $i -lt 20 ]; do' >> /etc/init.d/S45wifi-auto
printf '%s\n' '    [ -d /sys/class/net/$IFACE ] && break' >> /etc/init.d/S45wifi-auto
printf '%s\n' '    i=$((i+1)); sleep 1' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  done' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  [ -d /sys/class/net/$IFACE ] || { echo "FAIL (no iface)"; return 1; }' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  ip link set $IFACE up 2>/dev/null' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  sleep 1' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  killall wpa_supplicant 2>/dev/null' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  sleep 1' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  wpa_supplicant -B -i $IFACE -c $WPA_CONF' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  sleep 3' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  udhcpc -i $IFACE -n -q -t 8 -T 2 >/dev/null 2>&1' >> /etc/init.d/S45wifi-auto
printf '%s\n' '  if ip -4 addr show $IFACE | grep -q "inet "; then echo OK; else echo "FAIL (no dhcp)"; return 1; fi' >> /etc/init.d/S45wifi-auto
printf '%s\n' '}' >> /etc/init.d/S45wifi-auto
printf '%s\n' 'stop() { printf "Stopping wifi-auto: "; killall wpa_supplicant 2>/dev/null; echo OK; }' >> /etc/init.d/S45wifi-auto
printf '%s\n' 'case "$1" in start) start ;; stop) stop ;; restart|reload) stop; start ;; *) echo "Usage: $0 {start|stop|restart}"; exit 1 ;; esac' >> /etc/init.d/S45wifi-auto
printf '%s\n' 'exit $?' >> /etc/init.d/S45wifi-auto

chmod +x /etc/init.d/S45wifi-auto
ls -l /etc/init.d/S45wifi-auto
```

---

## 手动验证

```bash
/etc/init.d/S45wifi-auto restart
sleep 2
ip -4 addr show wlan0
ping -c 2 192.168.0.1
```

成功后再：

```bash
sync
reboot
```

---

## 建议你现在只做

优先用 **方法 B**（最不容易出错）：

1. `wifi-connect.sh ccccc2.4g '你的密码'`
2. 确认有 IP
3. `cp -a /tmp/wpa_supplicant.conf /etc/wpa_supplicant.conf`
4. 再创建 `S45wifi-auto`
5. 手动 `restart` 验证

把这几项结果回我（密码打码）：

```text
1. sed 检查配置是否是 ccccc2.4g
2. S45wifi-auto 是否存在
3. restart 后是否有 inet
4. ping 网关是否成功
```

## 6. 本课完成记录

2026-07-24 已完成：

- `/etc/wpa_supplicant.conf` 已保存有效配置。
- `/etc/init.d/S45wifi-auto` 已创建并赋予执行权限。
- 手动执行脚本成功：`wifi-auto: OK`。
- 重启后自动获取 `192.168.0.106`，网关 Ping 成功。
- 电脑通过 `ssh root@192.168.0.106` 登录成功。

复杂命令不要在 Windows PowerShell 中手工处理多层引号；使用：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "E:\Embed_Proj\tspi_rk3566\05_开发工具\第2课-创建WiFi自动脚本.ps1"
```

今天没有实际切换到另一个 Wi-Fi，只完成了切换流程的理解。
