#!/bin/bash
set -e

MASTER_HOST=master-nyc3.tmate.io
USER_FACING_HOST=staging.tmate.io

usage() {
  echo "Usage: $0 master"
  echo "       $0 edge EDGE_HOST"
  exit 1
}

configure_master() {
  cat <<-EOF
kind: ConfigMap
apiVersion: v1
metadata:
  name: config
data:
  hostname: "$MASTER_HOST"
  master_base_url: "https://$MASTER_HOST/"
EOF
}

configure_edge() {
 HOST=$1
 [ ! -z "$HOST" ] || usage

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
}

case "$1" in
  master) configure_master ;;
  edge) configure_edge "$2" ;;
  *) usage ;;
esac
