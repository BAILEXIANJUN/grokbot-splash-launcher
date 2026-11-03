# 在桌面创建「Grok Bot（启动动画）」快捷方式。不会修改任何已有快捷方式。
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
if (-not (Test-Path (Join-Path $root 'launch.vbs'))) { $root = $PSScriptRoot }
$vbs = Join-Path $root 'launch.vbs'
if (-not (Test-Path $vbs)) { throw "找不到 launch.vbs：$vbs" }
$exe = "$env:LOCALAPPDATA\Programs\Grok Bot\Grok Bot.exe"
$lnk = Join-Path ([Environment]::GetFolderPath('Desktop')) 'Grok Bot（启动动画）.lnk'
if (Test-Path $lnk) { Write-Host "快捷方式已存在，将覆盖（只覆盖本项目创建的这个）：$lnk" }
$s = (New-Object -ComObject WScript.Shell).CreateShortcut($lnk)
$s.TargetPath = "$env:WINDIR\System32\wscript.exe"
$s.Arguments = '"' + $vbs + '"'
$s.WorkingDirectory = $root
if (Test-Path $exe) { $s.IconLocation = "$exe,0" }
$s.Description = 'Grok Bot 启动动画（Grok娘 Splash）'
$s.Save()
Write-Host "已创建：$lnk"
