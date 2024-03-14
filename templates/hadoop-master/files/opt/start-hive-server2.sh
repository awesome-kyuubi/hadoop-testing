#!/bin/bash

set -exuo pipefail

wait-service-ready-mark -s hdfs

exec hive --service hiveserver2