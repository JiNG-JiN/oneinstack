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
  [ -s "${src_url##*/}" ] && echo "[${CMSG}${src_url##*/}${CEND}] found" || { wget --limit-rate=100M --tries=6 -c --no-check-certificate ${src_url}; sleep 1; }
  if [ ! -e "${src_url##*/}" ]; then
    echo "${CFAILURE}Auto download failed! You can manually download ${src_url} into the oneinstack/src directory.${CEND}"
    kill -9 $$; exit 1;
  fi
}

Download_src_v2() {
  local url=$1
  local file_name=${url##*/}

  [ -s "$file_name" ] && echo "[${CMSG}${file_name}${CEND}] found" || { wget --limit-rate=100M --tries=6 -c --no-check-certificate "$url"; sleep 1; }
  if [ ! -e "$file_name" ]; then
    echo "${CFAILURE}Auto download failed! You can manually download $url into the oneinstack/src directory.${CEND}"
    kill -9 $$; exit 1;
  fi
}
