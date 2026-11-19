#!/bin/bash

set -exuo pipefail

remove-service-ready-mark -s hdfs
{% if ranger_enabled and hdfs_ranger_enabled %}
# the mark is re-created once the hdfs repository is registered, so a stale mark
# on a reused /share volume cannot report the cluster healthy before that
remove-service-ready-mark -s ranger-agent-ready
{% endif %}

"$@" &

if [[ -v POST_BOOTSTRAP_COMMAND ]]; then
    $POST_BOOTSTRAP_COMMAND
fi

if [[ -d /opt/service-ready.d ]]; then
    for init_script in /opt/service-ready.d/*; do
        bash "${init_script}"
    done
fi

wait
