#!/bin/bash

set -exuo pipefail

wait-service-ready-mark -s hdfs

exec /opt/spark/sbin/start-history-server.sh
