#!/bin/bash
# Luca Cinema：默认只构建并导出 IPA；显式传 --upload 才上传到个人 TestFlight。
# 所有构建、归档、结果包、导出和大体积依赖缓存都必须留在 StudioSSD。
set -euo pipefail
upload=0
for arg in "$@"; do
  case "$arg" in
    --upload) upload=1 ;;
    *) printf '未知参数：%s（仅支持 --upload）\n' "$arg" >&2; exit 64 ;;
  esac
done
repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
scratch_dir="/Volumes/StudioSSD/Developer/BuildScratch/MovieClaw"
volume_uuid="$(diskutil info -plist /Volumes/StudioSSD | plutil -extract VolumeUUID raw -o - -)"
[[ "$volume_uuid" == '9D5FE511-B66C-4765-BB8F-61E5ACB3969D' && -w "$scratch_dir" ]] || exit 1
run_dir="${LUCA_RUN_DIR:-$scratch_dir/Luca-070-$(date -u +%Y%m%dT%H%M%SZ)}"
python3 - "$repo_dir" "$run_dir" <<'PY'
from pathlib import Path
import os,sys
repo,run=(Path(p).resolve() for p in sys.argv[1:])
assert str(repo).startswith('/Volumes/StudioSSD/') and os.access(repo,os.W_OK)
assert run.is_relative_to(Path('/Volumes/StudioSSD/Developer/BuildScratch'))
PY
mkdir -p "$run_dir/Temp"
export TMPDIR="$run_dir/Temp/"
cd "$repo_dir"
python3 scripts/prepare-project.py
build="${LUCA_BUILD_NUMBER:-$(date -u +%Y%m%d%H%M)}"
version="$(python3 - <<'PY'
from pathlib import Path
import re
print(re.search(r'MARKETING_VERSION: "([^"]+)"',Path('project.yml').read_text())[1])
PY
)"
printf '正在构建 Luca Cinema %s（%s）；日志：%s/archive.log\n' "$version" "$build" "$run_dir"
if ! xcodebuild -project MovieClaw.xcodeproj -scheme MovieClaw -configuration Release \
  -destination 'generic/platform=iOS' -archivePath "$run_dir/LucaCinema.xcarchive" \
  -derivedDataPath "$run_dir/DerivedData" -resultBundlePath "$run_dir/Archive.xcresult" \
  -clonedSourcePackagesDirPath "$scratch_dir/SourcePackages" \
  -packageAuthorizationProvider netrc -onlyUsePackageVersionsFromResolvedFile \
  -allowProvisioningUpdates CURRENT_PROJECT_VERSION="$build" \
  archive > "$run_dir/archive.log" 2>&1; then
  rg -n 'error:|ARCHIVE FAILED|BUILD FAILED' "$run_dir/archive.log" | tail -n 25 >&2 || true
  exit 1
fi
python3 - "$run_dir/ExportOptions.plist" "$upload" <<'PY'
from pathlib import Path
import plistlib,re,sys
team=re.search(r'^DEVELOPMENT_TEAM\s*=\s*(\S+)',Path('XcodeConfig/Signing.local.xcconfig').read_text(),re.M)[1]
with open(sys.argv[1],'wb') as f:
    plistlib.dump({'method':'app-store-connect','destination':'upload' if sys.argv[2]=='1' else 'export',
                  'teamID':team,'signingStyle':'automatic','manageAppVersionAndBuildNumber':False,
                  'uploadSymbols':True,'stripSwiftSymbols':True},f)
PY
if ! xcodebuild -exportArchive -archivePath "$run_dir/LucaCinema.xcarchive" \
  -exportPath "$run_dir/Export" -exportOptionsPlist "$run_dir/ExportOptions.plist" \
  -allowProvisioningUpdates -packageAuthorizationProvider netrc \
  > "$run_dir/export.log" 2>&1; then
  rg -n 'error:|Error|EXPORT FAILED' "$run_dir/export.log" | tail -n 25 >&2 || true
  exit 1
fi
if [[ "$upload" == 0 ]]; then
  mv "$run_dir/Export/MovieClaw.ipa" "$run_dir/Export/LucaCinema-$version-$build.ipa"
  printf '已导出：%s/Export/LucaCinema-%s-%s.ipa\n' "$run_dir" "$version" "$build"
else
  printf '上传命令已完成，仍须核对 Apple 处理与个人测试组状态。日志：%s\n' "$run_dir"
fi
