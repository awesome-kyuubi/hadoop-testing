#!/bin/bash

set -exuo pipefail

"$@" &

if [[ -v POST_BOOTSTRAP_COMMAND ]]; then
    $POST_BOOTSTRAP_COMMAND
fi

if [[ -d /docker/kerberos-init.d ]]; then
    for init_script in /docker/kerberos-init.d/*; do
        "${init_script}"
    done
fi

wait
