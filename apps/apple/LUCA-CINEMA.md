# Luca Cinema 个人构建与安装记录

当前源码基于 MovieClaw v0.44.0 / iOS 0.12.0；0.12.0（14）已上传并验证为 VALID / IN_BETA_TESTING，仍使用原 Luca Personal 内部 TestFlight 组；最低 iOS 26。

当前订阅接入只在 Web / 电脑助手添加和管理；iOS 读取服务器已有模型，并保留模型与思考强度选择。下方 0.7.0 手机内授权记录属于历史版本，已由本版替代。

- 显示名称：Luca Cinema。
- Bundle ID：com.o1xhack.lucacinema.app。
- 客户端使用独立 LC 图标；服务器仍为 MovieClaw。
- AetherEngine、FFmpeg 保留上游名称；ChatGPT 接入作为通用增强单独提交上游。
- 关于页附带 MovieClaw 完整许可证与修改声明（Shared/Resources/Licenses），保留依赖版权和许可。
- 当前仅作个人非商业内部 TestFlight 测试，未提交正式 App Store 审核。

本机签名由忽略的 XcodeConfig/Signing.local.xcconfig 配置。所有新构建、导出和日志放在 /Volumes/StudioSSD/Developer/BuildScratch/MovieClaw 下。App Store Connect 凭据从全局 Apple secret helper 读取，不写入仓库。

首次安装后，填写自己的 MovieClaw 服务器地址并登录。家庭公网访问配置属于独立任务；后续服务端功能部署见各版本验证记录。

## 已验证的 TestFlight 状态（2026-10-01）

App Store Connect App ID：6818384408。构建 0.2.0（1）已上传，Apple 处理状态 VALID，内部测试状态 IN_BETA_TESTING，已自动分发到 Luca Personal。唯一测试账号状态 INVITED。未开启外部测试或公开链接。

已查看源图标、archive 中的实际图标和 Apple CDN 处理后的图标；已验证签名、完整许可证与隐私清单进入安装包。尚未验证真机安装、登录或 NAS 媒体播放。

管理入口：https://appstoreconnect.apple.com/apps/6818384408/testflight/ios

## 0.3.0 更新状态（2026-10-02）

基于官方 v0.30.0 标签，构建 0.3.0（2）已上传；Apple 状态 VALID，内部状态 IN_BETA_TESTING，已进入原 Luca Personal 组。保留独立品牌、完整许可证及修改声明；实际归档签名、资源和 Apple CDN 图标均已核验。尚未验证真机播放，未修改 NAS 或公网配置。片头片尾功能需服务端 v0.30.0 提供识别数据。

本版源码位于 `/Volumes/StudioSSD/Projects/working/apple/LucaCinema`（分支 `luca-cinema-0.3.0`）；旧版工作目录保留。构建、IPA 与日志位于 `/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/Luca-030-20261002`。


## 0.7.0 完整上游同步与本地构建（2026-10-12）

完整合入 MovieClaw v0.37.0（上游提交 e229717c43b2d48986f8f51c19b86348a527cb5a），本地分支为 `luca-cinema-0.7.0`，应用源码 merge commit 为 `f9f369d24da2a07e0c4c7f8d4dfcbe7b7a985bb6`。旧版品牌与本机打包配置已保存在 `luca-cinema-0.3.0` 分支与构建目录内的独立备份中。

- 本地构建：Luca Cinema 0.7.0（3），最低 iOS 26；Archive 与 App Store Connect 方式的 IPA 导出成功。
- 主 App 与两个通知扩展的签名全部验证通过；导出的推送环境为 production，App Group 为 `group.com.o1xhack.lucacinema.app`。
- 已检查源图标与实际编译图标，均为 LC；图标无 Alpha。字体、App / 扩展 / AetherCore 的隐私清单与 MovieClaw 完整许可证均随包进入。
- AetherEngine 固定提交为 `aa3e04fab1e48134267e7fc763db645b388c9cd6`，直接沿用上游 Package.resolved；7 项依赖锁定测试通过。
- 推送代码与通知扩展已同步，但独立 Bundle ID 的实际推送仍需配置自己的 movieclaw-push 中继。
- 本轮只做本地构建与导出，未上传 TestFlight；真机安装、NAS 登录与媒体播放尚未验证。

产物与核验记录：

- Archive：`/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/Luca-070-20261013T035503Z/LucaCinema.xcarchive`
- IPA：`/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/Luca-070-20261013T035503Z/Export/LucaCinema-0.7.0-3.ipa`
- 核验：`/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/Luca-070-20261013T035503Z/build-verification.json`
- IPA SHA-256：`3f43fbc276bd0fbb9d8ea4a8ab5db8e187c10d7af9dcd4d5b09ed0ed8e1f8ace`

重新打包默认仅导出 IPA，显式添加 `--upload` 才上传；所有临时数据与 Xcode 分发日志使用 StudioSSD BuildScratch：

```bash
LUCA_BUILD_NUMBER=3 apps/apple/scripts/luca-testflight.sh
```

## 0.7.0 真机直装（2026-10-12）

按用户指定，将同一 Archive 内的 Development 签名 App 直接更新安装到 `the silver sword`（iPhone 17 Pro Max）。设备安装清单确认从 0.5.0（1）更新为 0.7.0（3）；启动命令成功，随后查询确认 App 进程仍在运行。未卸载 App 或清空数据，未上传本版 TestFlight。

设备通过 CoreDevice 可无线安装，但当前 sim-use 仅识别另一台已连接的 iPhone，无法读取此设备界面。因此登录状态、数据保留结果与 NAS 播放尚未实测。安装前后版本、安装结果、启动和进程记录保存在上述构建目录的 `sword-*.json` 中。


## ChatGPT 订阅接入与 0.7.0（4）（2026-10-13）

通用功能从干净上游 `598cddaa` 开始，提交 `f1bfde04` 已推到独立功能分支并提交 [上游 PR #846](https://github.com/movieclaw/MovieClaw/pull/846)。PR 只包含官方 ChatGPT 订阅授权、服务端协议、电脑 loopback 助手、Web/iOS 入口与验证；不包含 Luca 品牌、签名、服务器地址或个人凭据。真实订阅推理尚未验证，当前保留 Draft 状态。GitHub 已运行的 Python、Go、Web、iPhone、Mac、TV 等检查均通过；跳过的作业不计入已验证结果。

私人分支 `luca-cinema-chatgpt` 在现有 0.37.0 基础上 cherry-pick 为 `902c9543`；解决两处版本上下文冲突，保留原有私人发行配置。本地私人后端 165 项回归与 Go 全套测试通过，Web 生产构建完成。

Luca Cinema 0.7.0（4）Archive 和 App Store Connect 方式的 IPA 导出完成。Bundle ID、Team、App Group 与显示名称保持本文件原有配置；Development 签名和 Silver Sword 设备授权已核对。首次无线安装因 CoreDevice 连接超时失败，随后设备查询显示 tunnel unavailable；此版本尚未确认安装或启动，不能用编译或 Simulator 替代真机结果。未上传这版 TestFlight。

- 构建目录：`/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/ChatGPTPlan-20261013/Luca-070-4`
- IPA：`Export/LucaCinema-0.7.0-4.ipa`
- IPA SHA-256：`097cb5489c9efbecc90f669c52e6c620c336a2c3440456786465518e9a922521`
- 核验：`build-verification.json`；真机连接错误：`sword-install.json`、`sword-before-retry.json`

NAS 已使用 `local/movieclaw-chatgpt:0.37.0-20261013`，基于原始本地镜像加入此功能的后端、匹配的 API 目录、CLI 和 Web 产物。仅重建 MovieClaw，未重建 qBittorrent。Compose 与在线 SQLite 备份位于 NAS `/volume1/docker/movieclaw/chatgpt-build-20261013/backup`，数据库 quick_check 为 ok，部署后 MovieClaw 健康检查通过，现有供应商仍可读取，实际 NAS Web 已显示 ChatGPT 接入步骤。上游正式版本包含此功能前，普通官方镜像或应用内更新可能不含这个私人补丁；后续更新需要重新合入或确认上游已发布，不能将本地功能镜像误认为官方 Release。

Mac 的 `~/.local/bin/mclaw` 已安装并通过用户批准的本机助手配对。认证文件按标准 CLI 位置保存，目录 0700、凭据 0600，未记录在项目或 PR。官方 OpenAI 页面已到达 Luca Cinema 授权步骤；NAS 中尚未创建 ChatGPT 供应商，待实际授权与一次推理/工具调用验证。


## 0.7.0（4）TestFlight 上传完成（2026-10-13）

用户在外出后明确改为 TestFlight 分发，复用上述 Archive 上传，没有重建 App 或改变版本号。Apple 已处理为 `VALID`，内部状态为 `IN_BETA_TESTING`，通过 Luca Personal 组的 builds relationship 确认本构建已在原内部组。现有唯一测试账号状态为 `INSTALLED`，此状态不能代替本版真机更新与功能验证。

App ID 仍为 `6818384408`，本版 build ID 为 `0529f942-bca1-4a47-8c9d-c1bb0885967f`。中英文测试说明已写入并回读；源图标、实际编译图标以及 Apple CDN 图标均人工查看为 LC。未提交外部 Beta App Review，既有外部组未做新增分发。

完整上传记录在构建目录的 `upload.log`、`asc-build-state.json` 与 `build-verification.json`。Xcode 自行生成到系统临时目录的分发诊断包已移至同一 SSD 构建目录；未在代码或 PR 中保存 Apple 凭据。

官方 ChatGPT 接入入口已包含在本版，真实账号授权/订阅推理仍待完成，上游 PR 保持 Draft。待用户从 TestFlight 更新后进行 NAS 登录与实际播放验证。

管理入口：https://appstoreconnect.apple.com/apps/6818384408/testflight/ios

## iPhone 直接 ChatGPT 登录与 0.7.0（5）（2026-10-13）

本版补齐手机内的订阅登录：模型接入 → 连接 ChatGPT 订阅 → **Continue with ChatGPT**。系统 Safari 控制器打开官方登录页，手机上只绑定 `127.0.0.1` 的监听器接收回调，再通过已有认证接口交回服务器；PKCE 与令牌仍由服务器持有。取消页面关闭监听器，可重新登录；电脑命令保留为可展开的替代方式。

通用上游提交为 `3ef99529bbd6a36e9e3456a05ad68a5c7f90fd0d`，已更新同一 [PR #846](https://github.com/movieclaw/MovieClaw/pull/846)。私人 cherry-pick 为 `8344178d43fa5341afafb94b83235f1a9f64aa37`。上游已执行的 iPhone、Mac、TV、Python 分片、Go 和 Web 检查全部通过；跳过作业不视为验证。本次仅更新 iOS，沿用 NAS 已部署的授权接口，没有更改公网或下载器配置。

3 项原生回调测试通过，覆盖 Host/state/重复参数拒绝、真实 socket、一次性完成与取消后关闭端口。生产 Simulator 界面已打开真实官方登录页，取消/重试正常；使用模拟授权码与模拟 OpenAI 令牌/模型响应，走完真实服务器交换与加密保存并显示已连接账号。真实账号授权、订阅推理及真机播放仍待用户验证，PR 保持 Draft。

0.7.0（5）已上传并由 Apple 处理为 `VALID`，内部状态 `IN_BETA_TESTING`；通过 Luca Personal 的 builds relationship 确认已进入原内部组。中英文测试说明已写入并回读。主 App 和两个扩展的 Distribution 签名、版本、Bundle ID 与 App Group 已核验；源图标、实际编译图标和 Apple CDN 图标均为 LC。未提交外部 Beta App Review。

- Build ID：`62081ab0-c70c-4452-8fbe-aecda8619719`
- 构建目录：`/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/ChatGPTPlan-20261013/Luca-070-5`
- IPA：`Export/LucaCinema-0.7.0-5.ipa`
- SHA-256：`892f7d716ea58687f173de64b380fadafcd98d76873513746693b1a86482836d`
- 核验：`build-verification.json`、`asc-build-state.json`、`altool-build-status.json`；上传日志 `upload.log`
- 手机流程测试：上一层目录的 `mobile-qa-verification.json`、`mobile-official-login.png` 与 `mobile-connected.png`

Xcode 自行生成的两个分发诊断包均已移到本版 SSD 构建目录，Apple 凭据未写入仓库。


## 思考强度、快捷新会话与维护者反馈：0.7.0（6 / 7）（2026-10-13）

构建 6 已直接安装，补齐 GPT-6.1-sol 能力元数据与快捷新会话模型选择。外层保持一行小输入框；展开后显示模型按钮，菜单内选择思考强度，并传给新会话第一条消息。随后构建 7 合入上游维护者反馈：预览与账号文案、断开提醒、授权错误和凭据安全等修复，已更新安装在 Silver Sword，回读为 0.7.0（7），启动成功。采用 Development 签名且 get-task-allow 为 true，现有 App 数据保留；6、7 均未上传 TestFlight。

通用代码为 `887606b0`，私人 cherry-pick 为 `2a6b4d55`；上游验证记录为 `aee887af`，私人同步为 `34c47e3e`。私人 v0.37 没有上游新增的 models/discover 端点，因此该单个用例明确跳过，相关修复在上游 PR 中保留。

[PR #846](https://github.com/movieclaw/MovieClaw/pull/846) 已更新全部维护者反馈，并由 Draft 转为 ready for review，尚未合并。用户本人已确认手机真实账号登录与使用成功；NAS 默认模型连接测试为 active，已确认订阅 scope，并使用 GPT-6.1-sol high 档跑通 namespaced qa_echo 两轮调用及终态完成。请求接受 encrypted_content，但回显用例没有推理条目，不作为加密推理回放证据。

上游定向回归 198 项通过；私人 168 项通过、1 项因端点不在此基线跳过；两项生产 Simulator UI 测试确认快捷输入框折叠/展开行为与断开提醒。Go ChatGPT 用例、Web TypeScript/ESLint/生产构建通过。更新提交的 CI 仍在运行时，不视为全部通过。真机安装和启动由 CoreDevice 验证；sim-use 当前只能识别另一台手机，未在错误设备上操作，也未声称真机新控件已自动验收。

NAS 部署镜像 `local/movieclaw-chatgpt-review:0.37.0-20261013`（`69d8486b45e0`），包含累积后台修复及私人网页构建，健康检查通过。原 Compose 和在线 SQLite 备份留在 NAS，qBittorrent 容器身份与正常运行状态未改变，Plex identity 仍可读取。

- 本次证据目录：`/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/ReasoningFix-20261013`
- 构建 7：`Luca-070-7/LucaCinema.xcarchive`、`build-verification.json`、`sword-install.json`、`sword-after.json`、`sword-launch.json`
- 回归与界面：`review-regressions.xml`、`private-review-tests.log`、`ReviewUITest.xcresult`、`ReviewUIAttachments`
- 真实工具用例与部署：`real-tool-result.log`、`nas-review-deploy.log`、`review-verification.json`
- 验证边界：其他模型、真实远端撤销、额度耗尽、加密推理条目回放与本版真机媒体播放未全部实测。

## 0.38.0 / iOS 0.8.0（9）与 Web 管理接入（2026-10-13）

完整合入官方 `v0.38.0`（`ca019529b3c34cd67ef0571efad661dbf8b2df66`），私人 merge 为 `96da2976`。保留 Luca 名称、LC 图标、独立 Bundle ID / App Group、签名配置以及已有通用 ChatGPT 增强。重新生成原生 SDK，新增协议能力字段可兼容旧服务器缺字段的响应，并在编辑模型时保留。

按用户要求，iOS 移除订阅添加、登录、重新授权、用量链接与对应回调监听器；已有接入详情只读，没有编辑、删除或重新测试按钮。Web / 电脑助手负责授权与管理，App 继续使用服务器返回的模型和思考档位。外层快捷框保持一行，展开后再显示选项。通用提交 `c8d9ad50` / `7b1d5605` 已更新 [PR #846](https://github.com/movieclaw/MovieClaw/pull/846)，私人同步为 `d4726de9` / `28d71b03`。PR 最新提交全部已执行 CI 通过，跳过作业不计入通过；PR 为 ready for review，尚未合并。私人品牌、签名、地址和凭据未进入 PR。

NAS 已部署 `local/movieclaw-chatgpt:v0.38.0-20261013`，基于官方 0.38.0 镜像固定摘要及合入后的服务器源码、迁移和 Web 构建。健康检查确认版本 0.38.0、spec `457a3d85fd61b777`。只重建 MovieClaw，qBittorrent 身份及运行状态未改变，Plex identity 可读取；原有下载任务过滤代码与升级前一致。Compose 和部署前在线 SQLite 备份保存在 NAS `/volume1/docker/movieclaw/upgrade038-20261013/backup` 与 `/app/data/manual-backups/upgrade038-20261013`，未复制生产数据库或密钥到本地构建材料。

正式切换前，以禁网容器迁移 NAS 上的隔离数据库副本：迁移到 `9f3c6a2e1b58`，quick_check 为 ok，两家模型供应商、加密凭据可解密、GPT-6.1 五档能力和实例身份均保留。副本未执行 OAuth 刷新。0.38 数据库已迁移，回退旧镜像必须配合升级前数据库备份和匹配的密钥。

升级后，真实账号接入再次测试为 active；GPT-6.1-sol high 的 namespaced `qa_echo` 两轮调用、工具结果回传和最终 `QA OK` 均成功。请求接受 encrypted_content，但未返回推理条目，不视为已测试加密回放。

- 公共分支和私人分支各 248 项定向 Python 回归通过、5 项依赖本机 FFmpeg / Mac kernel / HDR 样本的集成测试跳过；Go 全套和 Web 生产构建通过。
- 新模型兼容与快捷草稿两项原生测试通过；两项生产 Simulator UI 测试确认接入只读、添加菜单无订阅，以及快捷框展开后 GPT-6.1 模型与五档控件仍可用。截图已人工查看。
- 隔离服务器的真实原生离线流程通过：下载合成影片、拒绝代理 TCP 连接、冷启动并播放本地影片、恢复连接并同步进度。没有在生产服务器删除媒体或测试下载任务。
- 容器启动监督用例在隔离 Linux 候选镜像内通过：一轮 15 项通过，补齐测试环境的 `pgrep` 后剩余一项通过。原先本机 3000 / 3001 占用时的失败不算通过，未终止其他项目服务。

Luca Cinema 0.8.0（9）Archive 成功。主 App 和两个扩展版本一致，签名验证通过，Development profile 包含目标手机，get-task-allow 为 true，App Group 正确；已查看 LC 源图及实际编译图标。CoreDevice 覆盖更新安装到 Silver Sword，回读 0.8.0（9），启动及存活进程确认成功；未卸载或清空 App 数据。本轮未上传 TestFlight，未提交 App Store 审核。当前 sim-use 未识别此目标手机，因此新界面与离线流程的自动化证据来自 Simulator，不能视为真机播放验收。

证据目录：`/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/Upgrade038-20261013`。最终 Archive、签名和手机安装/回读/启动记录在 `Luca-080-9`；总核验为 `upgrade-verification.json`，界面截图在 `WebManagedShots`。构建 8 是同轮升级的中间安装，已由构建 9 替代。


## 0.41.0 / iOS 0.9.2 完整同步与真机更新（2026-10-20）

完整合入稳定版 MovieClaw v0.41.0 / ios-v0.9.2（上游提交 `5b0739f54fc1e22ba2fd9c4037d132d16e85e0c1`），私人合并提交 `ea5e621f`，保留 Luca Cinema 显示名称、LC 图标、独立 Bundle ID、App Group、本机签名与完整许可证。远端 main 也已获取；发布标签后的未发布改动没有混入本版。ChatGPT PR #846 已被上游合并，并随 Server 0.39.0 发布，本次无需额外叠加 ChatGPT 私人补丁。

### NAS

- 从本地 0.38.0 功能镜像升级到官方 `movieclaw/movieclaw:v0.41.0`，运行时 23；仅保留既有的无投递台账外部下载任务隐藏补丁，派生镜像为 `local/movieclaw:v0.41.0-luca-external-20261020`。补丁只修改任务中心可见性，不改变 qB 下载、做种或文件。
- 官方基础镜像 digest：`sha256:55a558d42451a221e1df9d9226ac75cf9f54db1f3dc71c4c278ee14f9939c58f`。
- 升级前先做在线 SQLite 备份，在断网隔离容器中完成副本迁移、凭据解密和模型能力检查。随后正常停止 MovieClaw，对整个 data 目录做独立备份，完整性检查为 `ok`，再仅重建 MovieClaw。
- 完整数据和 compose 备份仅在 NAS `/volume1/docker/movieclaw/upgrade041-20261020/backup`；在线数据库和隔离副本在 NAS `/volume1/docker/movieclaw/data/manual-backups/upgrade041-20261020`。敏感备份目录为 0700；在线预备数据库和隔离密钥为 0600，完整目录副本保留原文件模式，不进入 Git。
- 生产版本 0.41.0、迁移头 `c5f1a8e3d9b2`、SQLite `quick_check=ok`，容器 healthy、重启次数 0。2 个库、6500 个库文件、466 个媒体条目、2 个供应商前后数量一致，已有供应商凭据解密成功。
- 已认证 API 返回 11 个模型，GPT-6.1-sol 保留 low / medium / high / xhigh / max。下载任务中心返回 81 个受管任务、0 个 external，下载器 active。qB 容器 ID 与启动时间前后一致，MovieClaw / qB / Plex HTTP 检查均为 200。
- 本版无转码器协议变更，未更新 Mac 转码器。未重新授权 ChatGPT，未执行消耗额度的模型推理。

### iOS

Luca Cinema 0.9.2（10）Archive 和 App Store Connect 方式 IPA 导出完成；主 App、两个通知扩展和导出包签名、版本、Bundle ID / App Group、设备授权、字体、隐私清单与完整许可证均通过检查。已查看 1024 源图标与归档中的实际编译图标，均为 LC；源图无 Alpha。

按既有要求直接覆盖安装到 the silver sword（iPhone 17 Pro Max），设备读回为 0.9.2（10），启动成功且进程存活。没有卸载或清空数据，本轮未上传 TestFlight。

新增可选 0.5×、0.75×、1×、1.25×、1.5×、2× 倍速，按影片记住速度；自动跳广告与已学习片头；局域网发现、离线入口、AI 输入与 iPad 布局改进均随上游合入。订阅接入继续仅在 Web / 电脑助手管理，iOS 使用服务端模型和思考档位；外层输入框保持单行，展开后显示模型选项。

验证：69 项定向原生测试、7 项依赖锁定测试、本地 Web lint / typecheck 通过。服务端、Web、CLI 与测试代码与上游发布标签一致，完整 Python/Go 等门禁使用发布 PR #945 的成功 CI 记录；未将 CI 跳过项视为通过。本轮真机证据限于安装、版本、签名、启动和进程存活；未实测真机 NAS 播放、画中画、HDR 或离线播放。

### 产物与回退

- 构建及核验目录：`/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/Upgrade041-20261020`
- IPA：`Luca-092-10/Export/LucaCinema-0.9.2-10.ipa`
- IPA SHA-256：`25b67f7c0a71e8ec8c0606d4845ac90dec4f37d1baae5a53314dae7861fc19e5`
- 核验：`build-verification.json`、`upgrade-verification.json`、`NativeTests.xcresult` 和 `sword-*.json`
- 上一版代码：本地备份分支 `backup/luca-before-041-20261020`。旧 Docker 镜像保留。NAS 回退必须停止 MovieClaw、恢复备份 data 与 compose，再启动旧镜像；不能让旧程序直接使用已迁移的新数据库。此回退会丢失升级后的新增数据，尚未执行。


## 播放画面缩放与 iPhone Air 真机验收（2026-10-21）

通用实现已提交 [上游 PR #972](https://github.com/movieclaw/MovieClaw/pull/972)，功能提交 `19e2a5ad`。个人分支同步 iOS 部分，保留 Luca 品牌、签名及此前的离线观看进度修复。

- 四模式：完整显示（默认）、适应宽度、铺满裁切、拉伸铺满。按钮循环切换，设置与长按菜单可直接选择。只属于当前播放文件，换片/换集恢复默认；同文件旋转与引擎重建保留选择。
- 字幕独立布局，新增模式按当前可见画面定位，修复暂停后旋转使用旧尺寸的问题；缩放时位图字幕保持比例并移回可见范围。
- 上游隔离分支的6项iOS定向回归、8项Web定向测试、Web类型检查及改动文件lint通过。Web通过Aside实际播放内置黑边1080p、普通16:9及4:3样片，确认同一video/地址/暂停位置不因模式循环改变。新增Playwright场景未单独执行pytest入口。
- Luca Cinema 0.9.2（11）开发签名构建和签名校验通过，直接安装至 iPhone Air；设备清单读回版本0.9.2（11）。真机验证默认布局、四模式、直接菜单、保持暂停位置、横竖屏和文字字幕；内置黑边样片按宽放大后左右贴边，并确认暂停旋转后的字幕回到可见画面内。
- 使用独立测试服务及短样片，没有部署NAS正式Web、修改原片或上传TestFlight。画中画/AirPlay仍由系统布局；烧录字幕仍随画面裁切。

证据与构建：`/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/DisplayModes-20261021`。


### 2026-10-21：按上游反馈精简播放缩放（build 12）

- 三模式：完整显示、铺满裁切、拉伸铺满；移除适应宽度和顶栏常驻按钮，现有设置菜单可选三种模式。
- iOS 捏合放大进入铺满裁切、捏合缩小恢复完整显示；设置菜单关闭后仍能捏合。
- 本次播放器内同剧自动连播、选集与换版本保留模式，切换影片或重新进入恢复默认。
- 保留原来的根 AVPlayerLayer 结构，仅切换 videoGravity，减少旋转时的图层尺寸风险。
- Air 已安装并运行 0.9.2 (12)：验证捏合、三模式、自动 S01E01 → S01E02 保留铺满，以及暂停时横竖屏保留模式/进度。
- 上游 PR #972 更新至 b50f7e22；Web 的 ASS 定位与 worker 修复位于独立上游 worktree，未改私有 Web。既有离线进度修复保持。

暂停旋转补充：普通完整显示也统一采用当前容器与片源显示比例计算字幕位置，修复暂停从横屏转竖屏后仍沿用旧 videoRect、字幕偏右裁切的问题。Air 复测完整显示的字幕边界为 [126,535,168,16]，位于竖屏视频区域内，暂停位置不变。对应上游 f70a1767。

## MovieClaw 0.43.0 与 Luca Cinema iOS 0.11.0（13）TestFlight（2026-10-26）

NAS 从应用 overlay 0.42.0 / 定制 runtime 23 镜像升级到官方 0.43.0 runtime 24 镜像基线。镜像 `local/movieclaw:v0.43.0-preserved-20261026` 在官方镜像上保留了私人部署的外部下载任务过滤，以及离线观看完成事件/续播位置修补；Compose 仅重建 MovieClaw。原 Compose、镜像和 0.42.0 overlay 留作回退。升级前停服归档位于 NAS `/volume1/docker/movieclaw/upgrade-20261026/data-critical-pre-v043.tar`（约 1.1 GB，含数据库、配置、更新记录；未重复归档缓存、元数据、转码、日志及既有备份，这些目录仍留在原数据卷）。恢复旧镜像时须同时恢复升级前数据库和 Compose，不能直接用迁移后的数据库回退。启动后 `/api/v1/health` 报 0.43.0、首页与健康接口均为 200、容器 `healthy` 且重启次数为 0；生产数据库 `quick_check=ok`。

私人 `luca-cinema-chatgpt` 分支合入上游 `origin/main` 的 `6dc217dc`，合并提交 `ae153ceb`，品牌生成文件提交 `96761167` 并推送到 `o1xhack/movieclaw`。保留 Luca Cinema 名称、LC 图标、独立 Bundle ID 与签名配置、播放器和离线观看改动；上游 iOS 版本更新至 0.11.0。离线观看完成事件相关 5 个定向用例通过，Xcode 27.1 Release 归档与严格签名校验通过。归档主 App 为 `com.o1xhack.lucacinema.app`、0.11.0（13），通知扩展 ID 同属该前缀，设备族包含 iPhone / iPad。源图 1024×1024 无 Alpha，归档 120×120 图标已查看且像素完全不透明，Apple CDN 图标回读也为 LC。

2026-10-26 本地 22:37 上传；ASC upload/build ID `50f88daf-2403-43b3-b19a-eb170c4a349d` 最终为 `COMPLETE` / `VALID`，pre-release train 为 iOS 0.11.0，`internalBuildState=IN_BETA_TESTING`，现有内部组 `Luca Personal` 含此构建（all-builds）。未提交 App Store 审核，也未加入外部测试组。构建、导出日志、归档及图标核验文件位于 `/Volumes/StudioSSD/Developer/BuildScratch/LucaCinema/ios-v0.11.0-build13`。真实 iPhone 安装与播放仍需单独 QA。

## MovieClaw 0.44.0 与 Luca Cinema iOS 0.12.0（14）（2026-10-29）

完整合入正式 `ios-v0.12.0` / `v0.44.0`（`2a6e6d2a58129a305e53f78639e7dafd82a1ec82`），私人合并提交 `3d9da66e416b49bbbc6de78591e52a7a0bb30030`。保留 Luca 名称、LC 图标、独立 Bundle ID / App Group、签名和许可证；播放器、离线下载队列、播出日历及 iPhone Duo 布局随上游合入。两处服务器冲突合并保留原始播放位置、离线 viewing_id 和正式 watch_source_ids。

NAS 基于官方 0.44.0 镜像摘要 `sha256:42bd98d35062d93bc5023a242c085871adf0199e38f374d11177f56bf6cc36d2`，派生镜像 `local/movieclaw:v0.44.0-preserved-20261029`（ID `43afe9166002`）保留既有离线补丁和外部下载过滤；Trakt #1063 直接沿用正式实现。只重建 MovieClaw，qBittorrent ID 与启动时间不变。停服一致备份为 `/volume1/docker/movieclaw/upgrade044-20261029/backup/data-before-v044.tar`（231219200 字节、84 个归档条目），旧 Compose、密钥与镜像均保留。回退必须配合匹配的数据和旧镜像，不能用旧代码直接打开已迁移数据库，也不能在有新用户数据后不加核对地覆盖整库。

禁网副本迁移和生产检查均通过：迁移头 `d7a25e81c4f0`、quick_check=ok、凭据可解密；2 个库、6517 文件、471 媒体、2466 播放状态、32 播放流水、2634 条导入历史、2 个模型供应商和 1 个站点配置数量一致。Trakt 账号密文摘要一致，插件 0.3.0-beta.3 active；用户现有偏好保留（手动标已看和收藏开启，取消已看关闭）。没有重新绑定或触发批量同步。服务 healthy、restarts=0，首页 HTTP 200；95 个受管下载任务、0 external。5 个实际补丁文件的摘要与构建清单一致，catalog 接口含 source_ids。

106 项后端回归、7 项私人离线专项和 11 项真实宿主插件集成通过（Trakt 模拟）。iOS 使用 Xcode 27.1 / iOS 27.1 SDK，604 项 Swift Testing、1 项中文 XCTest 和 22 项英文 XCTest 分语言复验通过；中文时间用例使用其预期的 Asia/Shanghai 环境。首轮混合语种/默认时区的失败日志保留，没有修改产品时间语义来迎合测试。8 项依赖锁定测试通过，AetherEngine 为 `0912813a54e9febe22be07e5c337bb58dfa7b2e5`，FFmpegBuild 为 3.10.1。

本地 0.12.0（14）Archive 与 IPA 导出完成，主 App 和两个通知扩展的版本、Bundle ID、严格签名、许可证及隐私清单已核对。2026-10-29 按用户要求上传同一签名包（SHA256 `a74c4ed6ec392738cbf53a0f4818c2ea3f15086011ee86d6d2df1d10cde6ef6c`），upload/build ID 为 `75c93c2a-dbad-477f-aaac-2f606c77d619`。Apple 处理完成，构建为 VALID、内部状态 IN_BETA_TESTING；组关系完整回读确认只有原 Luca Personal 内部组（`9bcb683d-a22a-47fc-8d3c-ff4206135f25`，all-builds），没有加入外部组。Apple 处理后的图标已查看，仍为正确 LC 图标。可以通过原 TestFlight 更新；未提交 App Store 审核，真实手机安装/登录/播放仍待 QA。

证据及产物目录：`/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw-upgrade/v044-20261029`。归档在 `ios-build14/LucaCinema.xcarchive`，导出包在 `ios-build14/Export`，结果为 `ios-tests/TestsChinese.xcresult` 和 `TestsEnglish.xcresult`；TestFlight 上传回执、处理结果、组关系及 Apple 图标在 `testflight14`。NAS 构建、迁移、验证和备份材料均在 `/volume1/docker/movieclaw/upgrade044-20261029`。
# 上游 iOS 0.12.1 同步（2026-10-30）

本轮合入官方稳定标签 `ios-v0.12.1`（`b3f86f98492b884aac6fcca515ef53ba94a4586c`，对应 v0.45.0 发布点），没有纳入标签之后的 main 改动。修复代理 VPN 被误认为回家隧道、VPN 开关后未立即重选地址，以及发现页标题菜单收起后的横向跳动。服务端最低要求仍为 0.28.0；本轮没有部署 NAS。

合并无冲突。此前相对上游的 19 个 Apple 定制文件逐项比较，仅 `project.yml` 的版本号变为 0.12.1；Luca 名称、LC 图标、播放器及离线改动保持。原私人签名配置保留且不入 Git，生成工程构建设置确认独立 Bundle ID 为 `com.o1xhack.lucacinema.app`。工程已重新生成，AetherEngine 版本锁定不变。

验证：Xcode 27.1 / iOS Simulator 27.1 编译成功；13 项 ServerRoutesTests 全部通过，包含 `issue1089EndToEnd` 本地健康接口与 VPN 网络切换场景；8 项依赖锁定检查和合并 diff 检查通过。发现页 UI 用例已合入，本轮未执行；未进行真机播放、Archive 或上传 TestFlight。此前 TestFlight 构建仍为 0.12.0（14）。

证据：`/Volumes/StudioSSD/Developer/BuildScratch/LucaCinema/sync-ios0121-20261030` 下的 `routes-tests.log`、`RoutesTests.xcresult` 和 `build-settings.log`。

## iOS 0.12.1（15）内部 TestFlight（2026-10-30）

按用户要求，基于 `1d962b99f` 归档并上传 Luca Cinema 0.12.1（15）。Xcode 27.1 Release Archive 与 App Store Connect 方式 IPA 导出成功；主 App、两个通知扩展的版本、独立 Bundle ID 和严格签名校验通过，设备族为 iPhone / iPad，字体、许可证、隐私清单均进入归档。源 LC 图标、逆优化后的归档图标和 Apple CDN 图标均已查看，源图及编译图无 Alpha。

上传 / build ID：`9004ad4d-322d-4963-9856-3df322d3f0dd`。Apple 上传状态 COMPLETE，构建 VALID / APP_STORE_ELIGIBLE，内部状态 IN_BETA_TESTING。完整组关系回读确认仅有原 Luca Personal 内部组（all-builds），没有加入外部组或提交 App Store 审核。已填中文和英文测试说明；真机登录、VPN 切换及播放仍待人工 QA。

产物和验证记录：`/Volumes/StudioSSD/Developer/BuildScratch/LucaCinema/testflight-0.12.1-15`。IPA SHA-256：`d59a22dffc492f5a008a815b2aa8f9294f5974c650d19b0f791e11382ed79afe`。
