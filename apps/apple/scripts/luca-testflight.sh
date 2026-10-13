#!/bin/bash
# Luca Cinema 的个人内部 TestFlight 构建；所有大体积产物必须留在 StudioSSD。
set -euo pipefail
repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
volume_uuid="$(diskutil info -plist /Volumes/StudioSSD | plutil -extract VolumeUUID raw -o - -)"
[[ "$volume_uuid" == '9D5FE511-B66C-4765-BB8F-61E5ACB3969D' && -w /Volumes/StudioSSD/Developer/BuildScratch ]] || exit 1
run_dir="/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/TestFlight-$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$run_dir"
cd "$repo_dir"
xcodegen generate
xcodebuild -project MovieClaw.xcodeproj -scheme MovieClaw -configuration Release \
 -destination 'generic/platform=iOS' -archivePath "$run_dir/LucaCinema.xcarchive" \
 -derivedDataPath "$run_dir/DerivedData" \
 -clonedSourcePackagesDirPath /Volumes/StudioSSD/Developer/BuildScratch/MovieClaw/SourcePackages \
 -packageAuthorizationProvider netrc -allowProvisioningUpdates \
 CURRENT_PROJECT_VERSION="${LUCA_BUILD_NUMBER:-$(date -u +%Y%m%d%H%M)}" archive > "$run_dir/archive.log" 2>&1
python3 - "$run_dir/ExportOptions.plist" <<'PY'
import plistlib,sys
with open(sys.argv[1],'wb') as f:
 plistlib.dump({'method':'app-store-connect','destination':'upload','teamID':'3TUERHN53E','signingStyle':'automatic','manageAppVersionAndBuildNumber':False,'uploadSymbols':True,'stripSwiftSymbols':True},f)
PY
xcodebuild -exportArchive -archivePath "$run_dir/LucaCinema.xcarchive" \
 -exportPath "$run_dir/Export" -exportOptionsPlist "$run_dir/ExportOptions.plist" \
 -allowProvisioningUpdates -packageAuthorizationProvider netrc > "$run_dir/export.log" 2>&1
printf 'Luca Cinema 构建上传命令已完成，仍须在 App Store Connect 核对处理及测试状态。日志：%s\n' "$run_dir"
