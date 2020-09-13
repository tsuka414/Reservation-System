#!/bin/bash
set -e

# server.pidファイルの削除
rm -f ${APP_HOME}/tmp/pids/server.pid

# DockerfileでCMDとして設定されているコマンドを実行
exec "$@"
