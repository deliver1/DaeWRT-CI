#!/bin/bash

#安装和更新软件包
UPDATE_PACKAGE() {
	local PKG_NAME=$1
	local PKG_REPO=$2
	local PKG_BRANCH=$3
	local PKG_SPECIAL=$4
	local PKG_LIST=("$PKG_NAME" $5)  # 第5个参数为自定义名称列表
	local REPO_NAME=${PKG_REPO#*/}

	echo " "

	# 删除本地可能存在的不同名称的软件包
	for NAME in "${PKG_LIST[@]}"; do
		# 查找匹配的目录
		echo "Search directory: $NAME"
		local FOUND_DIRS=$(find ../feeds/luci/ ../feeds/packages/ -maxdepth 3 -type d -iname "*$NAME*" 2>/dev/null)

		# 删除找到的目录
		if [ -n "$FOUND_DIRS" ]; then
			while read -r DIR; do
				rm -rf "$DIR"
				echo "Delete directory: $DIR"
			done <<< "$FOUND_DIRS"
		else
			echo "Not fonud directory: $NAME"
		fi
	done

	# 克隆 GitHub 仓库
	git clone --depth=1 --single-branch --branch $PKG_BRANCH "https://github.com/$PKG_REPO.git"

	# 处理克隆的仓库
	if [[ "$PKG_SPECIAL" == "pkg" ]]; then
		find ./$REPO_NAME/*/ -maxdepth 3 -type d -iname "*$PKG_NAME*" -prune -exec cp -rf {} ./ \;
		rm -rf ./$REPO_NAME/
	elif [[ "$PKG_SPECIAL" == "name" ]]; then
		mv -f $REPO_NAME $PKG_NAME
	fi
}

# 调用示例
# UPDATE_PACKAGE "OpenAppFilter" "destan19/OpenAppFilter" "master" "" "custom_name1 custom_name2"
# UPDATE_PACKAGE "open-app-filter" "destan19/OpenAppFilter" "master" "" "luci-app-appfilter oaf" 这样会把原有的open-app-filter，luci-app-appfilter，oaf相关组件删除，不会出现coremark错误。

# UPDATE_PACKAGE "包名" "项目地址" "项目分支" "pkg/name，可选，pkg为从大杂烩中单独提取包名插件；name为重命名为包名"
UPDATE_PACKAGE "argon" "sbwml/luci-theme-argon" "openwrt-25.12"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "aurora" "eamonxg/luci-theme-aurora" "master"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "aurora-config" "eamonxg/luci-app-aurora-config" "master"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "kucat" "sirpdboy/luci-theme-kucat" "master"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "kucat-config" "sirpdboy/luci-app-kucat-config" "master"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "noobwrt" "nooblk-98/luci-theme-noobwrt" "master"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "shadcn" "eamonxg/luci-theme-shadcn" "main"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "theme-fluent" "LazuliKao/luci-theme-fluent" "main"

# 618-v2 honk: HomeProxy/sing-box 已移除，代理只用 honk。honk 不走构建 feed，
# 由 daeuniverse apk feed 提供（honk-0.1.0_beta5-r1.apk），feed 仓库与签名由 Handles.sh 写入镜像，刷机后 apk 安装（见 PLAN.md）。
# （此前官方 HomeProxy + sing-box 1.14.4 的准备已全部作废，见 PLAN.md。)
UPDATE_PACKAGE "momo" "nikkinikki-org/OpenWrt-momo" "main"
UPDATE_PACKAGE "nikki" "nikkinikki-org/OpenWrt-nikki" "main"
#UPDATE_PACKAGE "openclash" "vernesong/OpenClash" "dev" "pkg"
#UPDATE_PACKAGE "passwall" "Openwrt-Passwall/openwrt-passwall" "main" "pkg"
#UPDATE_PACKAGE "passwall2" "Openwrt-Passwall/openwrt-passwall2" "main" "pkg"

#UPDATE_PACKAGE "luci-app-tailscale" "asvow/luci-app-tailscale" "main"

#UPDATE_PACKAGE "athena-led" "unraveloop/JDC-AX6600-Athena-LED-Controller" "main"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "ddns-go" "sirpdboy/luci-app-ddns-go" "main"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "diskman" "sbwml/luci-app-diskman" "main"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "diskmanager" "4IceG/luci-app-mini-diskmanager" "main"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "easytier" "EasyTier/luci-app-easytier" "main"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "mosdns" "sbwml/luci-app-mosdns" "v5" "" "v2dat"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "netspeedtest" "sirpdboy/netspeedtest" "main" "" "homebox ookla-speedtest"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "netwizard" "sirpdboy/luci-app-netwizard" "main"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "openlist2" "sbwml/luci-app-openlist2" "main"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "partexp" "sirpdboy/luci-app-partexp" "main"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "qbittorrent" "sbwml/luci-app-qbittorrent" "master" "" "qt6base qt6tools rblibtorrent"
#UPDATE_PACKAGE "qmodem" "FUjr/QModem" "main"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "quickfile" "sbwml/luci-app-quickfile" "main"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "timecontrol" "sirpdboy/luci-app-timecontrol" "main"
# 618-v2 honk: viking 克隆已删除——它只提供 sing-box + AI Edition HomeProxy + axonhub/gecoosac/timewol，
# 其中 sing-box/HomeProxy 已移除，其余在 GENERAL.txt 里都是 =n 或未选，克隆它只浪费构建时间。
# （此前 sing-box 1.14.4 钉死与 multi_queue 删除段已随 HomeProxy 一并作废，见 PLAN.md。)
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "vnt" "lmq8267/luci-app-vnt" "main"


# REMOVED for 618-v2: dae/daed 已移除（dae 2.1.1 不再编入；daed 为已归档的 dae 面板，
# Handles.sh 里原有的强制禁用 daed 不再需要亦无害，予以保留作兜底）
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "luci-app-pushbot" "zzsj0928/luci-app-pushbot" "master"
# PRUNED for OWRT trial (not used): UPDATE_PACKAGE "luci-app-nginx-manager" "hello-yunshu/luci-app-nginx-manager" "main"
#UPDATE_PACKAGE "luci-app-dockerman" "lisaac/luci-app-dockerman" "master"
#更新软件包版本
UPDATE_VERSION() {
	local PKG_NAME=$1
	local PKG_MARK=${2:-false}
	local PKG_FILES=$(find ./ ../feeds/packages/ -maxdepth 3 -type f -wholename "*/$PKG_NAME/Makefile")

	if [ -z "$PKG_FILES" ]; then
		echo "$PKG_NAME not found!"
		return
	fi

	echo -e "\n$PKG_NAME version update has started!"

	for PKG_FILE in $PKG_FILES; do
		local PKG_REPO=$(grep -Po "PKG_SOURCE_URL:=https://.*github.com/\K[^/]+/[^/]+(?=.*)" $PKG_FILE)
		local PKG_TAG=$(curl -sL "https://api.github.com/repos/$PKG_REPO/releases" | jq -r "map(select(.prerelease == $PKG_MARK)) | first | .tag_name")

		local OLD_VER=$(grep -Po "PKG_VERSION:=\K.*" "$PKG_FILE")
		local OLD_URL=$(grep -Po "PKG_SOURCE_URL:=\K.*" "$PKG_FILE")
		local OLD_FILE=$(grep -Po "PKG_SOURCE:=\K.*" "$PKG_FILE")
		local OLD_HASH=$(grep -Po "PKG_HASH:=\K.*" "$PKG_FILE")

		local PKG_URL=$([[ "$OLD_URL" == *"releases"* ]] && echo "${OLD_URL%/}/$OLD_FILE" || echo "${OLD_URL%/}")

		local NEW_VER=$(echo $PKG_TAG | sed -E 's/[^0-9]+/\./g; s/^\.|\.$//g')
		local NEW_URL=$(echo $PKG_URL | sed "s/\$(PKG_VERSION)/$NEW_VER/g; s/\$(PKG_NAME)/$PKG_NAME/g")
		local NEW_HASH=$(curl -sL "$NEW_URL" | sha256sum | cut -d ' ' -f 1)

		echo "old version: $OLD_VER $OLD_HASH"
		echo "new version: $NEW_VER $NEW_HASH"

		if [[ "$NEW_VER" =~ ^[0-9].* ]] && dpkg --compare-versions "$OLD_VER" lt "$NEW_VER"; then
			sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$NEW_VER/g" "$PKG_FILE"
			sed -i "s/PKG_HASH:=.*/PKG_HASH:=$NEW_HASH/g" "$PKG_FILE"
			echo "$PKG_FILE version has been updated!"
		else
			echo "$PKG_FILE version is already the latest!"
		fi
	done
}

#UPDATE_VERSION "软件包名" "测试版，true，可选，默认为否"
#UPDATE_VERSION "sing-box"
#UPDATE_VERSION "tailscale"

#引入私有扩展脚本
if [ -f "$GITHUB_WORKSPACE/Scripts/PRIVATE.sh" ]; then
	source "$GITHUB_WORKSPACE/Scripts/PRIVATE.sh"
fi

#删除官方的默认插件
rm -rf ../feeds/luci/applications/luci-app-{passwall*,mosdns,dae*,bypass*}
rm -rf ../feeds/packages/net/{v2ray-geodata,dae*}

cp -r $GITHUB_WORKSPACE/package/v2ray-geodata ./


# REMOVED for 618-v2: daed 修复段随 daed 克隆一并删除
