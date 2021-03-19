#!/bin/bash

export CHAT_ID=-1001165568594
export BOT_TOKEN=1769103266:AAHFb2yG3S3I5vspEQFtuTP-SvM1E0bjOfc
function tg_sendText() {
curl -s "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
-d "parse_mode=html" \
-d text="${1}" \
-d chat_id=$CHAT_ID \
-d "disable_web_page_preview=true"
}

function tg_sendFile() {
curl -F chat_id=$CHAT_ID -F document=@${1} -F parse_mode=markdown https://api.telegram.org/bot$BOT_TOKEN/sendDocument
}

MANIFEST=git://github.com/AOSiP/platform_manifest.git
BRANCH=eleven

mkdir -p /tmp/rom
cd /tmp/rom

# Repo init command, that -device,-mips,-darwin,-notdefault part will save you more time and storage to sync, add more according to your rom and choice. Optimization is welcomed! Let's make it quit, and with depth=1 so that no unnecessary things.
repo init -u "$MANIFEST" -b "$BRANCH"

tg_sendText "Downloading sources"
# Sync source with -q, no need unnecessary messages, you can remove -q if want! try with -j30 first, if fails, it will try again with -j8
repo sync --force-sync --no-tags --no-clone-bundle -j30 || repo sync --force-sync --no-tags --no-clone-bundle -j8
rm -rf .repo

# Sync device tree and stuffs
git clone -b arrow-11.0 https://github.com/coolhotham/device_lav.git device/xiaomi/lavender
git clone -b arrow-11.0 https://github.com/coolhotham/vendor_lav.git vendor/xiaomi/lavender
git clone -b Hmp https://github.com/NotZeetaa/nexus_kernel_lavender.git kernel/xiaomi/lavender

# Normal build steps
source build/envsetup.sh
export USE_CCACHE=0
lunch aosip_lavender-userdebug

# upload function for uploading rom zip file! I don't want unwanted builds in my google drive haha!
up(){
	curl --upload-file $1 https://transfer.sh/ | tee download.txt
}
tg_sendText "Building"
#mka api-stubs-docs
#mka system-api-stubs-docs
#mka test-api-stubs-docs
time m kronic
up out/target/product/lavender/*.zip
tg_sendText "download.txt"
up out/target/product/lavender/*.json
tg_sendText "download.txt"
