#!/bin/bash

set -exuo pipefail

wait-service-ready-mark -s hdfs

exec hbase master start
