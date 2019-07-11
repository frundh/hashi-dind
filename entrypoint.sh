#!/bin/bash

set -e

service docker start

if [ -z "$@" ]; then
  exec supervisord -c /etc/supervisor/conf.d/supervisord.conf --nodaemon
else
  echo "start consul & nomad agents"
  exec supervisord -c /etc/supervisor/conf.d/supervisord.conf & "$@"
fi