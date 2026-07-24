[CmdletBinding()]
param([string]$Root)

if ([string]::IsNullOrWhiteSpace($Root)) { $Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path) }
$ErrorActionPreference = 'Stop'
$sources = Get-Content -LiteralPath (Join-Path $Root '00_索引与说明\sources\sources.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$checks = foreach ($s in $sources) {
    $path = Join-Path $Root ($s.target -replace '/', '\')
    $exists = Test-Path -LiteralPath $path -PathType Leaf
    $size = if ($exists) { (Get-Item -LiteralPath $path).Length } else { 0 }
    $ok = $exists -and $size -gt 0
    [pscustomobject]@{ target=$s.target; access=$s.access; exists=$exists; size_bytes=$size; ok=$ok; url=$s.url }
}
$missing = @($checks | Where-Object { -not $_.ok })
$publicMissing = @($missing | Where-Object access -eq 'public')

$assetLinks = [System.Collections.Generic.List[object]]::new()
foreach ($md in Get-ChildItem -LiteralPath $Root -File -Recurse -Filter *.md) {
    $text = Get-Content -LiteralPath $md.FullName -Raw -Encoding UTF8
    foreach ($m in [regex]::Matches($text, '(?<path>(?:\.\./)+assets/[^\s<>)\]"'']+|assets/[^\s<>)\]"'']+)')) {
        $raw = $m.Groups['path'].Value.TrimEnd('.',',',';',':')
        $candidate = Join-Path (Split-Path -Parent $md.FullName) ($raw -replace '/', '\')
        try { $resolved = [IO.Path]::GetFullPath($candidate) } catch { $resolved = $candidate }
        $assetLinks.Add([pscustomobject]@{
            document=$md.FullName.Substring($Root.TrimEnd('\').Length+1).Replace('\','/')
            reference=$raw
            exists=(Test-Path -LiteralPath $resolved -PathType Leaf)
        })
    }
}
$missingAssets = @($assetLinks | Where-Object { -not $_.exists })
$partFiles = @(Get-ChildItem -LiteralPath $Root -File -Recurse -Filter *.part)
$manifestRepo = Join-Path $Root '04_SDK与镜像\公开仓库\TaishanPi-manifests\taishanpi_rk3566_linux5.10_release.xml'

$downloadIndexPath=Join-Path $Root '00_索引与说明\sources\downloaded-materials.json'
$downloadChecks=@()
if(Test-Path -LiteralPath $downloadIndexPath){
    $downloadIndex=Get-Content -LiteralPath $downloadIndexPath -Raw -Encoding UTF8|ConvertFrom-Json
    $downloadChecks=foreach($entry in $downloadIndex.files){
        $path=Join-Path $Root ($entry.path -replace '/', '\')
        $exists=Test-Path -LiteralPath $path -PathType Leaf
        $size=if($exists){(Get-Item -LiteralPath $path).Length}else{0}
        $sha=if($exists){(Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant()}else{''}
        [pscustomobject]@{path=$entry.path;exists=$exists;size_bytes=$size;size_ok=($size -eq [long]$entry.size_bytes);sha256=$sha;hash_ok=($sha -eq $entry.sha256)}
    }
}
$badDownloads=@($downloadChecks|Where-Object{-not $_.exists -or -not $_.size_ok -or -not $_.hash_ok})

$report = [pscustomobject]@{
    verified_at=(Get-Date).ToString('yyyy-MM-dd HH:mm:ss zzz')
    source_total=$checks.Count
    source_ok=@($checks | Where-Object ok).Count
    source_missing=$missing.Count
    public_missing=$publicMissing.Count
    local_asset_references=$assetLinks.Count
    local_asset_missing=$missingAssets.Count
    partial_files=$partFiles.Count
    taishanpi_manifest_present=(Test-Path -LiteralPath $manifestRepo -PathType Leaf)
    downloaded_materials_checked=@($downloadChecks).Count
    downloaded_materials_bad=$badDownloads.Count
    source_checks=$checks
    missing_asset_checks=$missingAssets
    downloaded_material_checks=$downloadChecks
}
$report | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $Root '00_索引与说明\verification-report.json') -Encoding UTF8
$report | Select-Object verified_at,source_total,source_ok,source_missing,public_missing,local_asset_references,local_asset_missing,partial_files,taishanpi_manifest_present,downloaded_materials_checked,downloaded_materials_bad | Format-List
if ($publicMissing.Count -gt 0 -or $missingAssets.Count -gt 0 -or $partFiles.Count -gt 0 -or -not $report.taishanpi_manifest_present -or $badDownloads.Count -gt 0) {
    if ($publicMissing.Count) { $publicMissing | Select-Object target,url | Format-Table -Wrap -AutoSize }
    if ($missingAssets.Count) { $missingAssets | Select-Object document,reference | Format-Table -Wrap -AutoSize }
    if ($badDownloads.Count) { $badDownloads | Format-Table -Wrap -AutoSize }
    exit 2
}
