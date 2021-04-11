#!/bin/sh -eu
debug=${debug:-}
# shellcheck disable=SC2046
$debug cd `dirname $0`
# shellcheck disable=SC1090
. ../envs/$ENV
$debug cd ../servers/$SERVER_DIR
$debug java -Xmx2048M -Xms2048M -jar ./$SERVER_FILE nogui