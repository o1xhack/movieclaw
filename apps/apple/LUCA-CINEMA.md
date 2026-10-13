# Luca Cinema 个人 TestFlight 构建

基于 MovieClaw v0.30.0，iOS 版本 0.3.0，最低 iOS 26。

- 显示名称：Luca Cinema。
- Bundle ID：com.o1xhack.lucacinema.app。
- 客户端使用独立 LC 图标；服务器仍为 MovieClaw。
- AetherEngine、FFmpeg 和服务端协议未改名、未修改。
- 关于页附带 MovieClaw 完整许可证与修改声明，保留依赖版权和许可。
- 当前仅作个人非商业内部 TestFlight 测试，未提交正式 App Store 审核。

本机签名由忽略的 XcodeConfig/Signing.local.xcconfig 配置。所有新构建、导出和日志放在 /Volumes/StudioSSD/Developer/BuildScratch/MovieClaw 下。App Store Connect 凭据从全局 Apple secret helper 读取，不写入仓库。

首次安装后，填写自己的 MovieClaw 服务器地址并登录。家庭公网访问配置属于独立任务，此次构建不修改 NAS 或路由器。

## 已验证的 TestFlight 状态（2026-10-01）

App Store Connect App ID：6818384408。构建 0.2.0（1）已上传，Apple 处理状态 VALID，内部测试状态 IN_BETA_TESTING，已自动分发到 Luca Personal。唯一测试账号状态 INVITED。未开启外部测试或公开链接。

已查看源图标、archive 中的实际图标和 Apple CDN 处理后的图标；已验证签名、完整许可证与隐私清单进入安装包。尚未验证真机安装、登录或 NAS 媒体播放。

管理入口：https://appstoreconnect.apple.com/apps/6818384408/testflight/ios

## 0.3.0 更新状态（2026-10-02）

基于官方 v0.30.0 标签，构建 0.3.0（2）已上传；Apple 状态 VALID，内部状态 IN_BETA_TESTING，已进入原 Luca Personal 组。保留独立品牌、完整许可证及修改声明；实际归档签名、资源和 Apple CDN 图标均已核验。尚未验证真机播放，未修改 NAS 或公网配置。片头片尾功能需服务端 v0.30.0 提供识别数据。

本版源码位于 `/Volumes/StudioSSD/Projects/working/apple/LucaCinema`（分支 `luca-cinema-0.3.0`）；旧版工作目录保留。构建、IPA 与日志位于 `/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/Luca-030-20261002`。
