#!/usr/bin/env bash

set -exuo pipefail

wait-port-ready -p 88
wait-port-ready -p 89
wait-port-ready -p 749