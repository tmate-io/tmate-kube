#!/bin/bash
set -e

MASTER_HOST=master-nyc3.tmate.io
USER_FACING_HOST=staging.tmate.io

usage() {
  echo "Usage: $0 HOSTNAME"
  exit 1
}

HOST=$1
[ -n "$HOST" ] || usage

cat <<-EOF
kind: ConfigMap
apiVersion: v1
metadata:
  name: config
data:
  hostname: "$HOST"
  websocket_base_url: "wss://$HOST/"
  master_base_url: "https://$MASTER_HOST/"
  user_facing_base_url: "https://$USER_FACING_HOST/"
EOF
