#!/usr/bin/env bash
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
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

function setup_config() {
    cp /etc/ranger/conf/* ${RANGER_HOME}/
    sed -i 's/__REPLACE_MYSQL_JDBC_VERSION__/'"${MYSQL_JDBC_VERSION}"'/g' "${RANGER_HOME}/install.properties"
}

function setup_ranger() {
    cd ${RANGER_HOME}
    sh setup.sh && sh ews/ranger-admin-services.sh start
}

setup_config

setup_ranger

RANGER_ADMIN_PID=`ps -ef | grep -v grep | grep -i "org.apache.ranger.server.tomcat.EmbeddedServer" | awk '{print $2}'`

tail --pid=$RANGER_ADMIN_PID -f /dev/null
