# 下载与安装

当前便携包版本为 **v1.0.0**。普通使用者下载便携包即可；源码 ZIP 用于查看和修改脚本，不包含安装用的 16:10 `splash.mp4`。

## 下载文件

| 文件 | 用途 | 大小 |
| --- | --- | --- |
| [GrokBotSplash-v1.0.0-portable.zip](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/GrokBotSplash-v1.0.0-portable.zip) | 启动脚本、16:10 动画和快捷方式工具 | 30,069,564 字节，约 30.1 MB |
| [grokbot-splash-preview.mp4](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/grokbot-splash-preview.mp4) | 原始 1920×1080 有声预览，约 23.8 秒 | 13,433,024 字节，约 13.4 MB |
| [SHA256SUMS.txt](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/SHA256SUMS.txt) | 上述两项 Release 文件的 SHA256 | 193 字节 |
| [仓库源码 ZIP](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/archive/refs/heads/main.zip) | 当前 `main` 分支源码及网页媒体 | 随仓库更新变化 |
| [preview-web.mp4](https://raw.githubusercontent.com/BAILEXIANJUN/grokbot-splash-launcher/main/media/preview-web.mp4) | 1280×720 网页播放副本，约 23.8 秒 | 4,307,223 字节，约 4.3 MB |

[返回主页播放器](../README.md#完整动画--在线播放) · [查看全部 Release](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases)

网页副本保留完整画面时长与原音轨，只压缩预览画面。原始预览及便携包内的启动视频保持不变。网页副本随 `main` 分支维护，不属于 v1.0.0 Release 校验文件的覆盖范围。

## 校验 SHA256

下载 ZIP 与同一 Release 的 `SHA256SUMS.txt` 后，在下载目录运行：

```powershell
Get-FileHash .\GrokBotSplash-v1.0.0-portable.zip -Algorithm SHA256
```

结果应与 `SHA256SUMS.txt` 对应行一致；不一致时停止安装并重新下载。当前已发布文件的校验值为：

```text
d41d7899a0da56a820ca18477223121306b91efff3afb9bb4bd4b2a45218a142  GrokBotSplash-v1.0.0-portable.zip
905a33bac820e8cfbf3918ac367547f592fce338dcea37ac82930771da298dc9  grokbot-splash-preview.mp4
```

当前仓库网页副本的 SHA256：

```text
0366ac109aff465a45c1e5406232df7ddcf758710845e4840d7df18a50ea7e19  media/preview-web.mp4
```

## 安装与启动

需要 Windows、PowerShell 5.1+、WPF 和可用的系统媒体组件。先确认 Grok Bot 桌面应用本身能正常打开；便携包不包含该应用。

1. 校验后，将便携包解压到长期保留的目录，例如 `D:\GrokBotSplash` 或 `%LOCALAPPDATA%\GrokBotSplash`。
2. 检查该目录根部包含 `launcher.ps1`、`launch.vbs`、`splash.mp4` 和 `scripts\`。
3. 双击 `launch.vbs`，全屏有声播放约 23.8 秒，然后进入 Grok Bot。Esc、空格、回车或鼠标点击可跳过。
4. 可选：右键**便携包中的** `scripts\Install-Shortcut.ps1`，选择「使用 PowerShell 运行」，创建桌面入口 **Grok Bot（启动动画）**。保留此便携目录，移动后需要重新创建入口。

默认 Grok Bot 路径为：

```text
%LOCALAPPDATA%\Programs\Grok Bot\Grok Bot.exe
```

安装在其他位置时，可通过 Windows 环境变量设置，将用户变量 `GROKBOT_EXE` 指向实际的 `Grok Bot.exe`。设置后重新登录 Windows，使桌面启动的进程获得新值。

`launch.vbs` 以隐藏窗口方式启动 PowerShell，并仅为本次进程使用 `-ExecutionPolicy Bypass`。排错请查看便携目录的 `launcher.log`；分享日志前自行检查本地路径等信息。

## 卸载与恢复

在原便携目录中运行 `scripts\Restore-Shortcut.ps1`，删除 **Grok Bot（启动动画）** 快捷方式，再删除便携目录。原有 Grok Bot 快捷方式不需要改动。

## 让 agent 下载

先阅读 [AGENTS.md](../AGENTS.md) 和 [distribution.json](../distribution.json)。在仓库源码根目录执行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\Download.ps1 `
  -Version v1.0.0 -Destination .\GrokBotDownload
```

脚本下载便携包与校验文件，通过 SHA256 校验后解压到指定目录，不运行启动器，不创建快捷方式。若下载返回 404 或校验失败，应停止并报告。

需要 agent 完成安装时，可以直接交代：

```text
请帮我安装 BAILEXIANJUN/grokbot-splash-launcher 的 v1.0.0：
先读 README.md、AGENTS.md 和 distribution.json；下载便携包与 SHA256SUMS.txt 并校验。
校验通过后解压到我指定的目录，运行便携包中的 scripts\Install-Shortcut.ps1 创建独立桌面入口。
不要改动原有 Grok Bot 快捷方式，安装完成后告诉我，不要自动播放动画或启动应用。
```

当前发布物已核验匿名下载、SHA256、包内结构和媒体参数；安装脚本及不同 Windows 环境的实际运行表现需分别验证。
