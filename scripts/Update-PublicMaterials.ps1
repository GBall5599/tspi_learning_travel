[CmdletBinding()]
param(
    [string]$Root,
    [string[]]$OnlyCategory,
    [switch]$Force
)

if ([string]::IsNullOrWhiteSpace($Root)) { $Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path) }

$ErrorActionPreference = 'Stop'
$sourceFile = Join-Path $Root '00_索引与说明\sources\sources.json'
$statusFile = Join-Path $Root '00_索引与说明\sources\download-status.json'
if (-not (Test-Path -LiteralPath $sourceFile)) { throw "来源配置不存在: $sourceFile" }
if (-not (Get-Command smart-search.cmd -ErrorAction SilentlyContinue)) { throw '未找到 smart-search.cmd，请先确认 smart-search-cli 已安装。' }

$sources = Get-Content -LiteralPath $sourceFile -Raw -Encoding UTF8 | ConvertFrom-Json
if ($OnlyCategory) { $sources = $sources | Where-Object { $_.category -in $OnlyCategory } }
$results = [System.Collections.Generic.List[object]]::new()

foreach ($source in $sources) {
    $target = Join-Path $Root ($source.target -replace '/', '\')
    $targetDir = Split-Path -Parent $target
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    $started = Get-Date

    if ($source.access -ne 'public') {
        @(
            "标题: $($source.title)",
            "状态: 需登录或人工下载",
            "来源: $($source.url)",
            "记录时间: $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss zzz'))",
            '',
            '本文件仅记录官方分享入口；自动更新脚本不会绕过登录、客户端或访问限制。'
        ) | Set-Content -LiteralPath $target -Encoding UTF8
        $results.Add([pscustomobject]@{ title=$source.title; category=$source.category; url=$source.url; target=$source.target; status='manual_required'; message='已生成下载入口索引'; elapsed_seconds=0 })
        continue
    }

    if ((-not $Force) -and (Test-Path -LiteralPath $target) -and ((Get-Item -LiteralPath $target).Length -gt 100)) {
        $results.Add([pscustomobject]@{ title=$source.title; category=$source.category; url=$source.url; target=$source.target; status='skipped'; message='目标已存在，使用 -Force 可重新抓取'; elapsed_seconds=0 })
        continue
    }

    $part = "$target.part"
    if (Test-Path -LiteralPath $part) { Remove-Item -LiteralPath $part -Force }
    Write-Host "[FETCH] $($source.url)"
    try {
        & smart-search.cmd fetch $source.url --format markdown --output $part | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "smart-search fetch 退出码 $LASTEXITCODE" }
        if (-not (Test-Path -LiteralPath $part)) { throw '未生成临时文件' }
        $body = Get-Content -LiteralPath $part -Raw -Encoding UTF8
        if ([string]::IsNullOrWhiteSpace($body)) { throw '抓取内容为空' }
        $header = @(
            '<!--',
            "source: $($source.url)",
            "retrieved_at: $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss zzz'))",
            "category: $($source.category)",
            '-->',
            ''
        ) -join "`r`n"
        Set-Content -LiteralPath $target -Value ($header + $body) -Encoding UTF8
        Remove-Item -LiteralPath $part -Force
        $results.Add([pscustomobject]@{ title=$source.title; category=$source.category; url=$source.url; target=$source.target; status='downloaded'; message='抓取成功'; elapsed_seconds=[math]::Round(((Get-Date)-$started).TotalSeconds,2) })
    } catch {
        if (Test-Path -LiteralPath $part) { Remove-Item -LiteralPath $part -Force }
        $results.Add([pscustomobject]@{ title=$source.title; category=$source.category; url=$source.url; target=$source.target; status='failed'; message=$_.Exception.Message; elapsed_seconds=[math]::Round(((Get-Date)-$started).TotalSeconds,2) })
        Write-Warning "抓取失败: $($source.url) - $($_.Exception.Message)"
    }
}

$summary = [pscustomobject]@{
    generated_at = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss zzz')
    root = $Root
    total = $results.Count
    downloaded = @($results | Where-Object status -eq 'downloaded').Count
    skipped = @($results | Where-Object status -eq 'skipped').Count
    manual_required = @($results | Where-Object status -eq 'manual_required').Count
    failed = @($results | Where-Object status -eq 'failed').Count
    results = $results
}
$summary | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $statusFile -Encoding UTF8
$summary | Select-Object generated_at,total,downloaded,skipped,manual_required,failed | Format-List
if ($summary.failed -gt 0) { exit 2 }



