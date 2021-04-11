#!/bin/sh -eu
# shellcheck disable=SC2046
cd `dirname $0`
# shellcheck disable=SC1090
. ../envs/$ENV
cd ../servers/$SERVER_DIR
java -Xmx2048M -Xms2048M -jar ./$SERVER_FILE nogui