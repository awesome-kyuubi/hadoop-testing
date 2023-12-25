#!/usr/bin/env bash

#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -xe

SELF_DIR="$(cd "$(dirname "$0")"; pwd)"

source "${SELF_DIR}/.env"

function build_ranger() {
  if [ -f download/ranger-${RANGER_VERSION}-admin.tar.gz ]; then
      echo "Skipping ranger build, using existing download/ranger-${RANGER_VERSION}-admin.tar.gz"
      return
  fi
  mkdir -p build/tmp
  tar -zxf download/apache-ranger-${RANGER_VERSION}.tar.gz -C build/tmp
  cp build/ranger/* build/tmp/apache-ranger-${RANGER_VERSION}/
  bash build/tmp/apache-ranger-${RANGER_VERSION}/build_ranger.sh
  cp build/tmp/apache-ranger-${RANGER_VERSION}/target/ranger-${RANGER_VERSION}-admin.tar.gz download/ranger-${RANGER_VERSION}-admin.tar.gz
}

build_ranger