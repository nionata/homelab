#!/usr/bin/env bash
set -euo pipefail

SERVER="${1:?Usage: $0 <server-ip>}"
DURATION=10

sep() { echo; echo "=== $* ==="; echo; }

sep "TCP Upload (client → server) | $SERVER"
iperf3 -c "$SERVER" -t "$DURATION"

sep "TCP Download (server → client) | $SERVER"
iperf3 -c "$SERVER" -t "$DURATION" -R

sep "TCP Multi-stream (4 parallel) | $SERVER"
iperf3 -c "$SERVER" -t "$DURATION" -P 4

sep "UDP | $SERVER"
iperf3 -c "$SERVER" -t "$DURATION" -u -b 250M
