# 下载便携包并校验 SHA256，然后解压。不会运行任何程序、不会创建快捷方式。
param([string]$Version = 'v1.0.0', [string]$Destination = "$env:LOCALAPPDATA\GrokBotSplash")
$ErrorActionPreference = 'Stop'
$base = "https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/$Version"
$zipName = "GrokBotSplash-$Version-portable.zip"
$tmp = Join-Path $env:TEMP ('gbs-' + [guid]::NewGuid())
New-Item -ItemType Directory $tmp | Out-Null
$zip = Join-Path $tmp $zipName; $sums = Join-Path $tmp 'SHA256SUMS.txt'
Invoke-WebRequest "$base/$zipName" -OutFile $zip -UseBasicParsing
Invoke-WebRequest "$base/SHA256SUMS.txt" -OutFile $sums -UseBasicParsing
$expected = (Get-Content $sums | Where-Object { $_ -match [regex]::Escape($zipName) } | Select-Object -First 1).Split(' ')[0]
$actual = (Get-FileHash $zip -Algorithm SHA256).Hash
if (-not $expected -or $expected -ine $actual) { throw "SHA256 校验失败：期望 $expected，实际 $actual" }
Expand-Archive $zip -DestinationPath $Destination -Force
Write-Host "校验通过，已解压到：$Destination"
