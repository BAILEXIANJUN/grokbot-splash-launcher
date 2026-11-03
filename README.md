# Grok娘 · Grok Bot 启动动画

给 Windows 上的 Grok Bot 加一段 23.8 秒的有声开场：Grok娘登场，说出「哼，才不是特意等你的呢。」和「快点，有活干了。」；结尾画面逐渐变暗，再进入最大化的 Grok Bot。

## 两个主要画面

**Grok娘登场 · 约 6 秒**

![Grok娘角色画面，约 6 秒](screenshots/hero_06s_eyes_open.png)

**Grok Bot 标题 · 约 15 秒**

![Grok Bot 标题画面，约 15 秒](screenshots/hero_15s.png)

## 完整动画 · 在线播放

**v1.0.0 · 23.8 秒完整有声预览**。点击下方播放器观看，两句台词和原音轨均保留。网页采用 1280×720、16:9 的轻量副本，约 4.3 MB。

https://github.com/user-attachments/assets/440fc630-2394-4625-8131-7835ccb42194

[备用 MP4 文件](https://raw.githubusercontent.com/BAILEXIANJUN/grokbot-splash-launcher/main/media/preview-web.mp4) · [下载原始 1080p 有声预览](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/grokbot-splash-preview.mp4)

<details>
<summary>查看自动循环的静音动图</summary>

![Grok娘启动动画的静音循环预览](media/preview.gif)

</details>

**[下载与安装](docs/DOWNLOADS.md) · [Agent 使用说明](AGENTS.md) · [预览维护说明](docs/PREVIEW.md) · [更新记录](CHANGELOG.md)**

**[下载 Windows 便携包](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/GrokBotSplash-v1.0.0-portable.zip) · [下载仓库源码](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/archive/refs/heads/main.zip) · [原始有声预览 MP4](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/grokbot-splash-preview.mp4) · [SHA256 校验](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/SHA256SUMS.txt)**

## 下载后怎么用

需要 Windows、PowerShell 5.1+、可用的 WPF 与系统媒体组件，以及已安装、能独立正常打开的 **Grok Bot 桌面应用**。便携包不包含 Grok Bot 安装程序。

1. 下载 `GrokBotSplash-v1.0.0-portable.zip`，对照同一 Release 的 `SHA256SUMS.txt` 校验后，解压到准备长期保留的目录，例如 `D:\GrokBotSplash`。
2. 双击解压目录根部的 `launch.vbs`，播放动画并进入 Grok Bot。
3. 需要桌面入口时，在**解压后的便携目录**中右键 `scripts\Install-Shortcut.ps1`，选择「使用 PowerShell 运行」，创建 **Grok Bot（启动动画）** 快捷方式。
4. 卸载时，运行同一目录的 `scripts\Restore-Shortcut.ps1` 删除这个快捷方式，再删除便携目录。

默认应用路径为 `%LOCALAPPDATA%\Programs\Grok Bot\Grok Bot.exe`；其他安装位置可通过环境变量 `GROKBOT_EXE` 指定。原有 Grok Bot 快捷方式不需要改动。详细下载、校验与路径说明见 [下载与安装](docs/DOWNLOADS.md)。

## 播放与启动行为

- 便携包使用 **2560×1600、16:10、30fps** 的 `splash.mp4`：16:9 主画面居中，上下使用同画面模糊填充；播放器等比例显示。网页的 16:9 预览与安装用视频分开维护。
- 约 6.8 秒与 14.6 秒出现两句台词；结尾定格在约 15.3 秒的画面，逐渐变暗至约 30% 亮度，保留可见画面。
- 播放期间按 **Esc / 空格 / 回车** 或单击鼠标可跳过；播放器设有 40 秒保险超时。
- 正常播放时，启动器在结束前约 1.5 秒预先启动 Grok Bot；关闭动画后等待真实应用窗口，将其置于前台并最大化。

这是通过快捷方式触发的应用启动器。日志保存在便携目录的 `launcher.log`。

## Codex / 其他 agent 下载

下载信息与便携包 SHA256 见 [distribution.json](distribution.json)，操作规范见 [AGENTS.md](AGENTS.md)。在下载或克隆的仓库源码目录中运行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\Download.ps1 `
  -Version v1.0.0 -Destination .\GrokBotDownload
```

脚本下载、校验并解压便携包，不自动运行程序或创建快捷方式。请明确要求 agent 安装到指定位置、保留原有快捷方式，并在运行有声全屏动画前取得你的同意。

## 源码与素材

```text
src/launcher.ps1              WPF 播放器、Grok Bot 启动与窗口最大化
src/launch.vbs                隐藏 PowerShell 窗口的入口
scripts/Download.ps1          下载、校验和解压便携包
scripts/Install-Shortcut.ps1  创建独立桌面快捷方式
scripts/Restore-Shortcut.ps1  删除本项目桌面快捷方式
media/preview.mp4             原始 1080p 网页预览
media/preview-web.mp4         720p 网页播放副本
media/preview.gif             静音循环动图
```

仓库源码 ZIP 是当前 `main` 分支的快照，与便携包用途不同；其中不含安装用的 16:10 `splash.mp4`。便携包将 `launcher.ps1`、`launch.vbs`、`splash.mp4` 放在根目录，可以直接使用。

启动器使用 PowerShell、WPF、VBScript 和 Win32 窗口 API。视频制作使用 FFmpeg；语音由 GPT-SoVITS 零样本克隆生成。网页预览的编码、上传与维护方式见 [预览维护说明](docs/PREVIEW.md)。

## 署名与许可

程序代码使用 [MIT](LICENSE)，仅覆盖 `src/` 与 `scripts/`。**MIT 不覆盖角色形象、图片、视频和语音**，相关权利归原权利人所有；仅供个人非商业使用，请勿用于商业用途或冒充他人声音。本项目为非官方粉丝作品，与 Grok Bot 官方无关。
