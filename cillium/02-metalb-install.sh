#!/bin/bash

KIND_NET_CIDR=$(docker network inspect kind -f '{{(index .IPAM.Config 0).Subnet}}')
METALLB_IP_START=$(echo ${KIND_NET_CIDR} | sed "s@0.0/16@255.200@")
METALLB_IP_END=$(echo ${KIND_NET_CIDR} | sed "s@0.0/16@255.250@")
METALLB_IP_RANGE="${METALLB_IP_START}-${METALLB_IP_END}"

helm upgrade --install --namespace metallb-system --create-namespace --repo https://metallb.github.io/metallb metallb metallb --values - <<EOF
configInline:
  address-pools:
  - name: default
    protocol: layer2       # use layer2 protocol
    addresses:
    - ${METALLB_IP_RANGE}  # configure the ip address range
EOF
