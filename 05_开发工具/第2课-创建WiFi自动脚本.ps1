<#
.SYNOPSIS
为泰山派 Buildroot 创建第 2 课 Wi-Fi 开机自动重连脚本。

.DESCRIPTION
该脚本把已验证正确的 /etc/wpa_supplicant.conf 配合 /etc/init.d/S45wifi-auto 使用。
不处理 Wi-Fi 密码，也不会读取或输出密码。
#>
param(
    [string]$Port = 'COM9',
    [int]$BaudRate = 1500000,
    [int]$Seconds = 15,
    [switch]$DryRun
)

$monitor = 'E:\Embed_Proj\tools\serial_monitor.ps1'
if (-not (Test-Path -LiteralPath $monitor)) {
    throw "找不到串口工具：$monitor"
}

# 远端命令本身没有 Wi-Fi 密码。它被作为一个 PowerShell 变量传给串口工具，
# 避免用户在终端中手工处理 Windows/BusyBox 的多层引号。
$remoteCommand = @"
printf '%s\n' '#!/bin/sh' 'echo "Starting wifi-auto"' 'for n in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do' '  [ -d /sys/class/net/wlan0 ] && break' '  sleep 1' 'done' '[ -d /sys/class/net/wlan0 ] || { echo "FAIL (no wlan0)"; exit 1; }' 'ip link set wlan0 up 2>/dev/null' 'sleep 1' 'killall wpa_supplicant 2>/dev/null' 'sleep 1' 'wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf' 'sleep 3' 'udhcpc -i wlan0 -n -q -t 8 -T 2' 'ip -4 addr show wlan0 | grep -q "inet " && echo "wifi-auto: OK" || echo "wifi-auto: FAIL (no DHCP)"' > /etc/init.d/S45wifi-auto; chmod 755 /etc/init.d/S45wifi-auto; echo '--- SCRIPT PERMISSION ---'; ls -l /etc/init.d/S45wifi-auto; echo '--- SCRIPT CONTENT ---'; cat /etc/init.d/S45wifi-auto
"@.Trim()

if ($DryRun) {
    Write-Host 'Dry run: the following password-free command would be sent to the board:'
    Write-Host $remoteCommand
    exit 0
}

Write-Host "Using $Port @ $BaudRate 8N1 to create /etc/init.d/S45wifi-auto..."
& $monitor -Port $Port -BaudRate $BaudRate -NoClear -Send $remoteCommand -Seconds $Seconds
exit $LASTEXITCODE
