[CmdletBinding()]
param(
    [string]$Root,
    [switch]$Force,
    [switch]$NoRewrite
)

if ([string]::IsNullOrWhiteSpace($Root)) { $Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path) }
$ErrorActionPreference = 'Stop'
if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '未找到 curl.exe。' }

function Get-RelativePath([string]$FromDirectory, [string]$ToPath) {
    $from = New-Object System.Uri(($FromDirectory.TrimEnd('\') + '\'))
    $to = New-Object System.Uri($ToPath)
    return [Uri]::UnescapeDataString($from.MakeRelativeUri($to).ToString()).Replace('\','/')
}

$allowedHosts = @('wiki.lckfb.com','image.lceda.cn','atta.szlcsc.com')
$extensionPattern = '\.(png|jpe?g|gif|svg|webp|pdf|zip|7z|rar|gz|tgz|tar|patch|dts|dtsi)$'
$markdownFiles = Get-ChildItem -LiteralPath $Root -File -Recurse -Filter *.md |
    Where-Object { $_.FullName -notlike "$(Join-Path $Root 'assets')*" }
$urlToRefs = @{}

foreach ($file in $markdownFiles) {
    $text = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    foreach ($match in [regex]::Matches($text, '(?:(?:https?:)?//[^\s<>)\]"'']+|(?<![A-Za-z0-9._-])/storage/[^\s<>)\]"'']+)')) {
        $raw = $match.Value.TrimEnd('.',',',';',':')
        $url = $raw
        if ($url.StartsWith('//')) { $url = 'https:' + $url }
        if ($url.StartsWith('/storage/')) { $url = 'https://wiki.lckfb.com' + $url }
        try { $uri = [uri]$url } catch { continue }
        if ($uri.Host -notin $allowedHosts -or $uri.AbsolutePath -notmatch $extensionPattern) { continue }
        if (-not $urlToRefs.ContainsKey($url)) { $urlToRefs[$url] = [System.Collections.Generic.List[object]]::new() }
        $urlToRefs[$url].Add([pscustomobject]@{ file=$file.FullName; raw=$raw })
    }
}

$results = [System.Collections.Generic.List[object]]::new()
foreach ($url in ($urlToRefs.Keys | Sort-Object)) {
    $uri = [uri]$url
    $decodedPath = [Uri]::UnescapeDataString($uri.AbsolutePath).TrimStart('/')
    $segments = $decodedPath -split '/' | ForEach-Object { ($_ -replace '[<>:"|?*]', '_') }
    $assetPath = Join-Path $Root ('assets\' + $uri.Host + '\' + ($segments -join '\'))
    $assetDir = Split-Path -Parent $assetPath
    New-Item -ItemType Directory -Path $assetDir -Force | Out-Null
    if ((-not $Force) -and (Test-Path -LiteralPath $assetPath) -and ((Get-Item -LiteralPath $assetPath).Length -gt 0)) {
        $status = 'skipped'
        $message = '已存在'
    } else {
        $part = "$assetPath.part"
        if (Test-Path -LiteralPath $part) { Remove-Item -LiteralPath $part -Force }
        Write-Host "[ASSET] $url"
        & curl.exe -L --fail --silent --show-error --retry 3 --connect-timeout 20 --output $part $url
        if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $part) -or (Get-Item -LiteralPath $part).Length -eq 0) {
            if (Test-Path -LiteralPath $part) { Remove-Item -LiteralPath $part -Force }
            $results.Add([pscustomobject]@{url=$url;target='';status='failed';size_bytes=0;message="curl 退出码 $LASTEXITCODE"})
            continue
        }
        Move-Item -LiteralPath $part -Destination $assetPath -Force
        $status = 'downloaded'
        $message = '下载成功'
    }

    if (-not $NoRewrite) {
        foreach ($ref in $urlToRefs[$url]) {
            $doc = Get-Content -LiteralPath $ref.file -Raw -Encoding UTF8
            $relative = Get-RelativePath (Split-Path -Parent $ref.file) $assetPath
            $doc = $doc.Replace($ref.raw, $relative)
            Set-Content -LiteralPath $ref.file -Value $doc -Encoding UTF8
        }
    }
    $target = $assetPath.Substring($Root.TrimEnd('\').Length + 1).Replace('\','/')
    $results.Add([pscustomobject]@{url=$url;target=$target;status=$status;size_bytes=(Get-Item -LiteralPath $assetPath).Length;message=$message})
}

$report = [pscustomobject]@{
    generated_at=(Get-Date).ToString('yyyy-MM-dd HH:mm:ss zzz')
    total=$results.Count
    downloaded=@($results | Where-Object status -eq 'downloaded').Count
    skipped=@($results | Where-Object status -eq 'skipped').Count
    failed=@($results | Where-Object status -eq 'failed').Count
    assets=$results
}
$report | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $Root '00_索引与说明\sources\asset-download-status.json') -Encoding UTF8
$report | Select-Object generated_at,total,downloaded,skipped,failed | Format-List
if ($report.failed -gt 0) { exit 2 }

