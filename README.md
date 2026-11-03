# Grok Bot 启动动画（Grok娘 Splash）

启动 Grok Bot 时，先全屏播放一段 Grok娘 开场动画，播完后自动以**最大化**窗口打开真正的 Grok Bot。

![Grok娘](screenshots/hero_06s_eyes_open.png)

![Grok Bot 标题画面](screenshots/hero_15s.png)

## 🎬 预览

[![点击观看预览视频](media/preview.gif)](media/preview.mp4)

▶️ [观看完整预览视频（16:9，23.8 秒，带声音）](media/preview.mp4) · [Release 下载](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/grokbot-splash-preview.mp4)

## 📥 下载

[![下载便携包](https://img.shields.io/badge/下载-便携包%20v1.0.0-blue?style=for-the-badge)](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/GrokBotSplash-v1.0.0-portable.zip)
[![预览视频](https://img.shields.io/badge/预览-MP4-orange?style=for-the-badge)](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/grokbot-splash-preview.mp4)
[![SHA256](https://img.shields.io/badge/校验-SHA256SUMS-green?style=for-the-badge)](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/SHA256SUMS.txt)
[![全部版本](https://img.shields.io/badge/Releases-全部版本-lightgrey?style=for-the-badge)](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases)

## ✨ 特点

- 时长 23.8 秒。实际部署的 `splash.mp4` 为 **16:10** 版：主画面保持 16:9 居中，上下用放大模糊的同一画面填充，16:10 屏幕上没有黑边（16:9 屏幕同样正常显示）。
- 两句台词：
  - 6.8s：「哼，才不是特意等你的呢。」
  - 14.6s：「快点，有活干了。」
- 结尾定格在 15.3s 的画面，亮度渐暗到约 30%，**不会全黑**；结束前约 1.5 秒预先启动 Grok Bot，随后最大化弹出，衔接自然。
- Esc / 空格 / 回车 / 鼠标点击随时跳过；40 秒保险超时，不会卡住。

## 🚀 安装与使用

1. 下载 [`GrokBotSplash-v1.0.0-portable.zip`](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/GrokBotSplash-v1.0.0-portable.zip)，（可选）对照 `SHA256SUMS.txt` 校验。
2. 解压到任意目录，例如 `D:\GrokBotSplash` 或 `%LOCALAPPDATA%\GrokBotSplash`。
3. 右键 `scripts\Install-Shortcut.ps1` →「使用 PowerShell 运行」，桌面会出现 **「Grok Bot（启动动画）」** 快捷方式。
4. 以后双击这个快捷方式启动 Grok Bot 即可。也可以直接双击 `launch.vbs`。
5. 不想要了：运行 `scripts\Restore-Shortcut.ps1` 删除该快捷方式，再删除文件夹。原版 Grok Bot 快捷方式始终不会被改动。

> 默认 Grok Bot 路径为 `%LOCALAPPDATA%\Programs\Grok Bot\Grok Bot.exe`。装在别处时，设置环境变量 `GROKBOT_EXE` 指向实际的 exe。

## 📦 获取方式

**方式一：直接下载**

从 [Releases](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases) 下载便携包，按上面的步骤安装。

**方式二：让 AI 助手帮你装**

把下面这段话发给能操作你电脑的 AI 助手（比如 Grok Bot）：

```text
请帮我安装 Grok Bot 启动动画：
1. 阅读 https://github.com/BAILEXIANJUN/grokbot-splash-launcher 的 README.md 和 AGENTS.md。
2. 从 v1.0.0 Release 下载 GrokBotSplash-v1.0.0-portable.zip 和 SHA256SUMS.txt，校验 SHA256。
3. 解压到 %LOCALAPPDATA%\GrokBotSplash。
4. 运行 scripts\Install-Shortcut.ps1，在桌面创建「Grok Bot（启动动画）」快捷方式，不要改动原有快捷方式。
5. 安装完先告诉我，不要自动运行。
```

AI 助手的详细操作规范见 [AGENTS.md](AGENTS.md)，下载信息见 [distribution.json](distribution.json)。

## 🗂️ 目录结构

```text
src/launcher.ps1              WPF 全屏播放器 + 启动并最大化 Grok Bot
src/launch.vbs                无窗口启动 launcher.ps1
scripts/Install-Shortcut.ps1  创建桌面快捷方式
scripts/Restore-Shortcut.ps1  删除该快捷方式
scripts/Download.ps1          下载并校验便携包
media/preview.mp4             16:9 预览视频
```

便携包内的 `launcher.ps1`、`launch.vbs`、`splash.mp4` 位于根目录。

## 🛠️ 技术栈

- **ffmpeg**：剪辑、淡入淡出、模糊填充、混音
- **GPT-SoVITS**：语音零样本克隆（v2ProPlus 预训练模型，未额外训练，参考音频约 3.5 秒）
- **PowerShell + WPF**：MediaElement 全屏播放（Stretch=Uniform，无边框、置顶）
- **VBScript**：隐藏窗口启动
- **Win32 user32 API**：`ShowWindow(SW_MAXIMIZE)` 最大化并置前台

## ⚠️ 注意事项

- 仅支持 Windows，需要系统自带的 PowerShell 5.1+。
- 首次运行若被执行策略拦截，`launch.vbs` 已使用 `-ExecutionPolicy Bypass`，仅作用于本次进程。
- 运行日志写在安装目录下的 `launcher.log`。
- **版权说明**：MIT 许可仅覆盖 `src/` 与 `scripts/` 中的代码。角色形象、图片、视频和语音（GPT-SoVITS 零样本克隆生成）不在 MIT 授权范围内，相关权利归原权利人所有；仅供个人非商业使用，请勿用于商业用途或冒充他人声音。
- 本项目为粉丝作品，与 Grok Bot 官方无关。

## 📄 许可

代码：[MIT](LICENSE)。更新记录见 [CHANGELOG.md](CHANGELOG.md)。
