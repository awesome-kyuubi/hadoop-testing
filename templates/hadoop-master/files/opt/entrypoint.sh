#!/bin/bash

set -exuo pipefail

remove-service-ready-mark -s hdfs

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
