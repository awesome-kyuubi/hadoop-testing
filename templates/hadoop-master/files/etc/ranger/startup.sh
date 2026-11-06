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

function setup_ranger() {
    cp /etc/ranger/conf/* ${RANGER_HOME}/
    sed -i 's/__REPLACE_MYSQL_JDBC_VERSION__/'"${MYSQL_JDBC_VERSION}"'/g' "${RANGER_HOME}/install.properties"

    cd ${RANGER_HOME}
    # verifies the schema and the db patches, sets the admin accounts and
    # publishes the embedded service definitions to the db
    sh setup.sh

    touch ${RANGER_HOME}/.setupDone
}

if [ ! -e ${RANGER_HOME}/.setupDone ]; then
    setup_ranger
fi

cd ${RANGER_HOME}
sh ews/ranger-admin-services.sh restart

RANGER_ADMIN_PID=`ps -ef | grep -v grep | grep -i "org.apache.ranger.server.tomcat.EmbeddedServer" | awk '{print $2}'`

tail --pid=$RANGER_ADMIN_PID -f /dev/null
