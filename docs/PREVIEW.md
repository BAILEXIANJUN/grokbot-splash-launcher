# 网页预览维护

主页使用 GitHub 附件提供原生视频播放器，静音 GIF 放在折叠区域。项目下载、原始预览和网页播放副本分别保留各自入口。

## 原入口为什么不能直接播放

原 README 将 GIF 和「观看完整预览视频」链接指向仓库的 `media/preview.mp4` 文件页。这个文件为 **13,433,024 字节，约 13.4 MB**，用户点击后遇到 GitHub 文件页的体积限制提示。匿名文件页响应也将它标记为 `large: true`、`viewable: false`。

检查表明原视频已使用 H.264 High、`yuv420p`、AAC LC，并且 `moov` 位于 `mdat` 之前，已具备 faststart。此次故障不需要重做动画或配音；应将主页入口改为 GitHub 原生附件播放器，并提供较小的播放副本。

## 三份视频的用途

| 视频 | 画面与时长 | 用途 |
| --- | --- | --- |
| `media/preview.mp4` / Release `grokbot-splash-preview.mp4` | 1920×1080、16:9、30fps；视频 23.800 秒，音频 23.808 秒 | 保留原始网页预览，13,433,024 字节 |
| `media/preview-web.mp4` | 1280×720、16:9、30fps；714 帧，视频 23.800 秒，音频 23.808 秒 | 主页原生播放器副本，4,307,223 字节 |
| 便携包内 `splash.mp4` | 2560×1600、16:10、30fps；视频与音频均 23.800 秒 | 安装后实际播放的启动动画，30,087,567 字节 |

网页副本只对原始预览画面进行缩放和压缩，完整保留帧数、时长及 AAC 音轨，不替换便携包内的视频。v1.0.0 Release 的原始 MP4、便携 ZIP 和校验文件保持不变。

## 重建网页副本

在仓库根目录运行 FFmpeg：

```powershell
ffmpeg -i media/preview.mp4 -map 0:v:0 -map 0:a:0 -vf scale=1280:720 -c:v libx264 -preset slow -crf 28 -maxrate 2200k -bufsize 4400k -pix_fmt yuv420p -c:a copy -movflags +faststart media/preview-web.mp4
```

这条命令不剪切内容，音频使用流复制。重新编码结果的大小和 SHA256 可能随 FFmpeg 版本变化；更新后同步 [下载说明](DOWNLOADS.md) 中的参数和网页副本校验值，不要将它混入原 v1.0.0 的 `SHA256SUMS.txt`。

## 上传为 GitHub 原生视频

1. 登录有仓库写入权限的 GitHub 账号，打开仓库 README 编辑页，或打开仅用于上传附件的 Markdown 编辑草稿。
2. 将 `media/preview-web.mp4` 通过编辑器的附件选择功能上传，等待上传完成，复制 GitHub 返回的 `https://github.com/user-attachments/assets/...` URL。
3. 将这个 URL 单独放在 README「完整动画 · 在线播放」段落中，前后留空行。不要包装为图片链接或代码块，也不要继续使用仓库 `blob` 文件页作为播放器入口。
4. 保存 README。若使用其他编辑草稿承载上传，取得 URL 后退出草稿，不发布无关 issue 或评论。
5. 保留 [网页 MP4 备用文件](https://raw.githubusercontent.com/BAILEXIANJUN/grokbot-splash-launcher/main/media/preview-web.mp4) 和 [原始 MP4 下载](https://github.com/BAILEXIANJUN/grokbot-splash-launcher/releases/download/v1.0.0/grokbot-splash-preview.mp4)，便于播放器加载失败时获取文件。

## 发布后验证

- 在未登录的浏览器会话打开仓库主页，确认两张 Grok 截图、播放器和折叠 GIF 正常显示。
- 点击播放器，确认不再跳到大文件提示页；等待加载，检查有声播放、时间推进、约 23.8 秒完整结束及播放末段。
- 在匿名会话验证主页附件播放器的实际视频流，以及备用 MP4、原始 Release MP4、便携包、校验文件、源码 ZIP 和文档链接。附件地址单独写入 Markdown 供 GitHub 转换为播放器；独立观看入口使用主页播放器。
- 重新下载原始 Release MP4 和便携包，对照 `distribution.json`、`SHA256SUMS.txt` 校验，确认主页更新未改变发布物。

无需运行 `launch.vbs`、创建快捷方式或修改本机安装即可完成网页预览验证。不要使用 `launcher.ps1 -Test` 做独立预览：当前代码虽定义该参数，仍会启动 Grok Bot。
