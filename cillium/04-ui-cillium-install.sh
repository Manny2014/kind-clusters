#!/bin/bash

LB_IP=$(kubectl get svc -n ingress-nginx ingress-nginx-controller -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
helm upgrade --namespace kube-system --repo https://helm.cilium.io cilium cilium --reuse-values --values - <<EOF
hubble:
  ui:
    enabled: true
    ingress:
      enabled: true
      annotations:
        kubernetes.io/ingress.class: nginx
      hosts:
        - hubble-ui.${LB_IP}.nip.io
EOF
