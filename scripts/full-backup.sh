#!/bin/bash -eu
# debug mode
debug=${debug:-}

function error_handler() {
  echo "ERROR" >&2
  exit 1
}
# コマンドの返り値が非ゼロのときハンドラを実行するように指定する
trap error_handler ERR

# shellcheck disable=SC2046
$debug cd `dirname $0`
# shellcheck disable=SC1090
. ../envs/$ENV

MC_PATH=../servers/$SERVER_DIR
BK_GEN="3"

BK_DIR=../backups
BK_TIME=`date +%Y%m%d-%H%M%S`
BK_PREFIX="mc_full_"
BK_SUFFIX=".tar.gz"
BK_NAME=$BK_PREFIX$BK_TIME$BK_SUFFIX
BK_PATH="$BK_DIR/$ENV/$BK_NAME"

echo "[`date`]: ==== Full backup start mc-server@$ENV data ===="

# サービスが生きてるか
$debug systemctl status mc-server@$ENV > /dev/null

echo "[`date`]: > Stopping mc-server@$ENV ..."
# サービスを一旦停止
$debug systemctl stop mc-server@$ENV
# 停止まで30sかかるので待つ
$debug sleep 32
echo "[`date`]: > Stopped mc-server@$ENV"

echo "[`date`]: >> Full Backup start ..."
# バックアップ
$debug tar cfz $BK_PATH $MC_PATH
# 完了するまで念の為ちょっと待つ
$debug sleep 10
echo "[`date`]: >> Full Backup compleate!"

echo "[`date`]: >> Old Backup removing ..."
# 古いものを削除
$debug find $BK_DIR/$ENV -name "$BK_PREFIX*$BK_SUFFIX" -type f -mtime +$BK_GEN -exec rm {} \;
echo "[`date`]: >> Old Backup remove done!"

# 止めてたサービスを開始する
echo "[`date`]: > Starting mc-server@$ENV ..."
$debug systemctl start mc-server@$ENV
echo "[`date`]: Full backup end!"
