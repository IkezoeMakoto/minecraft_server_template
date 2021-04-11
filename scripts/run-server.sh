#!/bin/sh -eu
# shellcheck disable=SC2046
cd `dirname $0`
# SERVERからパスを取得して移動
cd ../servers/${SERVER%/*}
# SERVERからファイルを取得して実行
java -Xmx2048M -Xms2048M -jar ./${SERVER##*/} nogui