[CmdletBinding()]
param([string]$Root)

if ([string]::IsNullOrWhiteSpace($Root)) { $Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path) }

$ErrorActionPreference = 'Stop'
$sourceFile = Join-Path $Root '00_索引与说明\sources\sources.json'
$sources = Get-Content -LiteralPath $sourceFile -Raw -Encoding UTF8 | ConvertFrom-Json
$sourceByTarget = @{}
foreach ($s in $sources) { $sourceByTarget[$s.target.Replace('\','/')] = $s }

$excluded = @(
    '00_索引与说明/manifest.csv',
    '00_索引与说明/manifest.json',
    'string'
)
$rows = foreach ($file in Get-ChildItem -LiteralPath $Root -File -Recurse | Where-Object { $_.FullName -notlike '*\.git\*' } | Sort-Object FullName) {
    $relative = $file.FullName.Substring($Root.TrimEnd('\').Length + 1).Replace('\','/')
    if ($relative -in $excluded -or $relative.EndsWith('.part')) { continue }
    $source = $sourceByTarget[$relative]
    $hash = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
    [pscustomobject]@{
        path = $relative
        category = if ($source) { $source.category } else { 'local' }
        source_url = if ($source) { $source.url } else { '' }
        access = if ($source) { $source.access } else { 'local' }
        status = if ($source -and $source.access -ne 'public') { 'manual_required_indexed' } elseif ($source) { 'downloaded' } else { 'generated' }
        size_bytes = $file.Length
        sha256 = $hash
        modified_at = $file.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss zzz')
    }
}

$manifestJson = Join-Path $Root '00_索引与说明\manifest.json'
$manifestCsv = Join-Path $Root '00_索引与说明\manifest.csv'
$payload = [pscustomobject]@{
    generated_at = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss zzz')
    root = $Root
    file_count = @($rows).Count
    total_size_bytes = (@($rows) | Measure-Object size_bytes -Sum).Sum
    files = @($rows)
}
$payload | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $manifestJson -Encoding UTF8
@($rows) | Export-Csv -LiteralPath $manifestCsv -NoTypeInformation -Encoding UTF8
$payload | Select-Object generated_at,file_count,total_size_bytes | Format-List






