#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 9+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

get_download_url() {
    local file_name=$1
    local html_content=$(wget -qO- "${mirror_link}/oneinstack/src" || curl -s "${mirror_link}/oneinstack/src")
    local url=$(echo "$html_content" | grep -oP 'href="\K[^"]+' | grep "$file_name" | head -1)
    [[ -z "$url" ]] && url="${mirror_link}/oneinstack/src/${file_name}"
    echo "$url"
}

# 修改后的 Download_src 函数
Download_src() {
    local file_name=${src_url##*/}
    local download_url=$(get_download_url "$file_name")
    [ -s "$file_name" ] && echo "[${CMSG}${file_name}${CEND}] found" || { wget --limit-rate=100M --tries=6 -c --no-check-certificate "$download_url"; sleep 1; }
    if [ ! -e "$file_name" ]; then
        echo "${CFAILURE}自动下载失败！你可以手动下载 $download_url 到 oneinstack/src 目录。${CEND}"
        kill -9 $$; exit 1;
    fi
}