#!/usr/bin/env bash

set -exuo pipefail

wait-port-ready -p 8020 -t ${HDFS_READY_TIMEOUT_SEC:-180}
