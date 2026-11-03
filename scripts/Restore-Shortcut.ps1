# 删除本项目创建的「Grok Bot（启动动画）」快捷方式。原版 Grok Bot 快捷方式不受影响。
$lnk = Join-Path ([Environment]::GetFolderPath('Desktop')) 'Grok Bot（启动动画）.lnk'
if (Test-Path $lnk) { Remove-Item -LiteralPath $lnk; Write-Host "已删除：$lnk" } else { Write-Host '未找到本项目的快捷方式，无需恢复。' }
