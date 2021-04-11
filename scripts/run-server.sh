#!/bin/sh -eu
# shellcheck disable=SC2046
cd `dirname $0`
cd ../server

java -Xmx2048M -Xms2048M -jar ./${SERVER:-minecraft.jar} nogui