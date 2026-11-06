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

# The PDP polls its policies from Ranger Admin, so it must not start before the
# admin finished its setup and published the service definitions it serves.
for _ in $(seq 1 ${RANGER_ADMIN_READY_RETRIES:-60}); do
    if curl -sf -o /dev/null http://localhost:6080/index.html; then
        break
    fi
    sleep 5
done

curl -sf -o /dev/null http://localhost:6080/index.html

cd ${RANGER_PDP_HOME}

exec ./ranger-pdp-services.sh run
