#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 9+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Download_src() {
  local file_name=${src_url##*/}
  
  # 特殊处理 GitHub 链接
  if [[ "$src_url" == *github.com/P-H-C/phc-winner-argon2/archive/refs/tags/* ]]; then
    argon2_ver=$(echo $src_url | grep -oP '(?<=tags/)[^/.]+')
    file_name="phc-winner-argon2-${argon2_ver}.tar.gz"
  fi

  [ -s "$file_name" ] && echo "[${CMSG}${file_name}${CEND}] found" || { wget --limit-rate=100M --tries=6 -c --no-check-certificate -O "$file_name" "$src_url"; sleep 1; }
  if [ ! -e "$file_name" ]; then
    echo "${CFAILURE}Auto download failed! You can manually download $src_url into the oneinstack/src directory.${CEND}"
    kill -9 $$; exit 1;
  fi
}
