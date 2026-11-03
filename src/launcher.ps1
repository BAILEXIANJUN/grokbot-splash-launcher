# Grok Bot 启动动画启动器
param([switch]$Test)
$ErrorActionPreference = 'Continue'
$Root  = $PSScriptRoot
$Video = Join-Path $Root 'splash.mp4'
$Exe   = "$env:LOCALAPPDATA\Programs\Grok Bot\Grok Bot.exe"
if ($env:GROKBOT_EXE) { $Exe = $env:GROKBOT_EXE }
$Log   = Join-Path $Root 'launcher.log'
function L($m){ "$(Get-Date -f 'HH:mm:ss.fff') $m" | Add-Content -Path $Log -Encoding UTF8 }

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase
Add-Type @'
using System; using System.Runtime.InteropServices;
public class GBW {
  [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int c);
  [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
  [DllImport("user32.dll")] public static extern bool IsZoomed(IntPtr h);
  [DllImport("user32.dll")] public static extern bool IsIconic(IntPtr h);
  [DllImport("user32.dll")] public static extern void keybd_event(byte k, byte s, uint f, UIntPtr e);
  [DllImport("user32.dll")] public static extern bool BringWindowToTop(IntPtr h);
}
'@
L 'start'
$launched = $false
function Start-Grok { if (-not $script:launched) { $script:launched = $true; L 'launch Grok Bot'; Start-Process -FilePath $Exe -WorkingDirectory (Split-Path $Exe) } }

$alreadyRunning = @(Get-Process -Name 'Grok Bot' -EA 0).Count -gt 0
if (Test-Path $Video) {
  $win = New-Object System.Windows.Window
  $win.WindowStyle = 'None'; $win.ResizeMode = 'NoResize'; $win.Topmost = $true
  $win.WindowState = 'Maximized'; $win.Background = 'Black'; $win.ShowInTaskbar = $false
  $win.Cursor = [System.Windows.Input.Cursors]::None
  $me = New-Object System.Windows.Controls.MediaElement
  $me.LoadedBehavior = 'Manual'; $me.UnloadedBehavior = 'Stop'; $me.Stretch = 'Uniform'; $me.Volume = 1
  $me.Source = [Uri]$Video
  $win.Content = $me
  $timer = New-Object System.Windows.Threading.DispatcherTimer
  $timer.Interval = [TimeSpan]::FromMilliseconds(200)
  $timer.Add_Tick({
    if ($me.NaturalDuration.HasTimeSpan) {
      $left = $me.NaturalDuration.TimeSpan - $me.Position
      if ($left.TotalSeconds -le 1.5) { Start-Grok }
    }
  })
  $close = { $timer.Stop(); $win.Close() }
  $me.Add_MediaOpened({ L "media opened $($me.NaturalDuration)" })
  $me.Add_MediaEnded($close)
  $me.Add_MediaFailed({ L "media failed $($_.ErrorException)"; & $close })
  $win.Add_KeyDown({ if ($_.Key -eq 'Escape' -or $_.Key -eq 'Space' -or $_.Key -eq 'Return') { L 'skip key'; & $close } })
  $win.Add_MouseDown({ L 'skip click'; & $close })
  $win.Add_Loaded({ $me.Play(); $timer.Start(); $win.Activate() })
  # 保险：最长 40 秒
  $guard = New-Object System.Windows.Threading.DispatcherTimer
  $guard.Interval = [TimeSpan]::FromSeconds(40); $guard.Add_Tick({ L 'guard timeout'; & $close }); $guard.Start()
  [void]$win.ShowDialog()
  L 'splash closed'
} else { L 'video missing' }

Start-Grok
# 等待主窗口句柄（最多 30 秒）
$h = [IntPtr]::Zero; $sw = [Diagnostics.Stopwatch]::StartNew()
while ($sw.Elapsed.TotalSeconds -lt 30) {
  $p = Get-Process -Name 'Grok Bot' -EA 0 | ? { $_.MainWindowHandle -ne 0 } | select -First 1
  if ($p) { $h = $p.MainWindowHandle; break }
  Start-Sleep -Milliseconds 250
}
if ($h -eq [IntPtr]::Zero) { L 'no window handle (timeout)'; exit 1 }
Start-Sleep -Milliseconds 400
if ([GBW]::IsIconic($h)) { [void][GBW]::ShowWindow($h, 9) }   # SW_RESTORE
[void][GBW]::ShowWindow($h, 3)                                 # SW_MAXIMIZE
[GBW]::keybd_event(0x12,0,0,[UIntPtr]::Zero); [GBW]::keybd_event(0x12,0,2,[UIntPtr]::Zero)  # Alt 解锁前台
[void][GBW]::BringWindowToTop($h); [void][GBW]::SetForegroundWindow($h)
L "hwnd=$h zoomed=$([GBW]::IsZoomed($h)) alreadyRunning=$alreadyRunning"
