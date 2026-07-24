[CmdletBinding()]
param(
    [string]$Root,
    [string]$ShareUrl = 'https://pan.baidu.com/s/5m1jN3xFWAu_8qbUbidNeMw',
    [long]$ShareId = 66941391540,
    [long]$ShareUk = 888641893,
    [string]$StartDirectory = '/立创·泰山派开发板资料'
)
if ([string]::IsNullOrWhiteSpace($Root)) { $Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path) }
$ErrorActionPreference='Stop'
$cookie=Join-Path $env:TEMP 'baidu-tspi.cookies'
$ua='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/138.0.0.0 Safari/537.36'
if(-not(Test-Path -LiteralPath $cookie)){
  & curl.exe -L --fail --silent --show-error -A $ua -c $cookie -b $cookie -o (Join-Path $env:TEMP 'baidu-tspi.html') $ShareUrl
  if($LASTEXITCODE -ne 0){throw "初始化分享页失败: $LASTEXITCODE"}
}
$queue=[System.Collections.Generic.Queue[string]]::new(); $queue.Enqueue($StartDirectory)
$seen=[System.Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)
$items=[System.Collections.Generic.List[object]]::new()
while($queue.Count -gt 0){
  $dir=$queue.Dequeue(); if(-not $seen.Add($dir)){continue}
  Write-Host "[LIST] $dir"
  $page=1
  do {
    $encoded=[uri]::EscapeDataString($dir)
    $url="https://pan.baidu.com/share/list?app_id=250528&channel=chunlei&clienttype=0&desc=0&num=1000&order=name&page=$page&root=0&shareid=$ShareId&showempty=0&uk=$ShareUk&dir=$encoded&web=1"
    $tmp=Join-Path $env:TEMP 'baidu-share-list-current.json'
    & curl.exe -L --fail --silent --show-error -A $ua -e $ShareUrl -b $cookie -o $tmp $url
    if($LASTEXITCODE -ne 0){throw "目录请求失败: $dir"}
    $response=Get-Content -LiteralPath $tmp -Raw -Encoding UTF8|ConvertFrom-Json
    if($response.errno -ne 0){throw "目录接口 errno=$($response.errno): $dir"}
    $list=@($response.list)
    foreach($entry in $list){
      $row=[pscustomobject]@{
        fs_id=[string]$entry.fs_id
        name=$entry.server_filename
        path=$entry.path
        is_directory=([int]$entry.isdir -eq 1)
        size_bytes=[long]$entry.size
        md5=$entry.md5
        category=$entry.category
        server_mtime=$entry.server_mtime
      }
      $items.Add($row)
      if($row.is_directory){$queue.Enqueue($row.path)}
    }
    $page++
  } while($list.Count -ge 1000)
  Start-Sleep -Milliseconds 120
}
$outDir=Join-Path $Root '00_索引与说明\sources'; New-Item -ItemType Directory -Path $outDir -Force|Out-Null
$files=@($items|Where-Object{-not $_.is_directory}); $dirs=@($items|Where-Object{$_.is_directory})
$payload=[pscustomobject]@{
  generated_at=(Get-Date).ToString('yyyy-MM-dd HH:mm:ss zzz')
  share_url=$ShareUrl
  share_id=[string]$ShareId
  share_uk=[string]$ShareUk
  start_directory=$StartDirectory
  directory_count=$dirs.Count
  file_count=$files.Count
  total_file_size_bytes=($files|Measure-Object size_bytes -Sum).Sum
  items=$items
}
$payload|ConvertTo-Json -Depth 6|Set-Content -LiteralPath (Join-Path $outDir 'baidu-public-index.json') -Encoding UTF8
$items|Export-Csv -LiteralPath (Join-Path $outDir 'baidu-public-index.csv') -NoTypeInformation -Encoding UTF8
$payload|Select generated_at,directory_count,file_count,total_file_size_bytes,@{n='total_size_gb';e={[math]::Round($_.total_file_size_bytes/1GB,2)}}|Format-List
