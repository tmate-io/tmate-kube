#!/bin/bash
set -ex

ROOT="tmate.io"
SUBDOMAINS="staging master-nyc3 nyc1 nyc3 sfo2 sgp1 lon1 tor1 elasticsearch kibana grafana prometheus"

function usage {
  echo "Usage: $0 CERT_NAME"
  exit 1
}

CERT_NAME=$1
[ -n "$CERT_NAME" ] || usage

DOMAINS=$ROOT
for SUB in $SUBDOMAINS; do
  DOMAINS+=",${SUB}.${ROOT}"
done

doctl compute certificate create --type lets_encrypt --name $CERT_NAME --dns-names $DOMAINS
