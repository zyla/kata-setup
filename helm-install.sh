#!/bin/bash

set -euo pipefail

# Install directly from the official ghcr.io OCI regitry
# update the VERSION X.YY.Z to your needs or just use the latest

export VERSION=$(curl -sSL https://api.github.com/repos/kata-containers/kata-containers/releases/latest | jq .tag_name | tr -d '"')
export CHART="oci://ghcr.io/kata-containers/kata-deploy-charts/kata-deploy"

helm install kata-deploy -n kube-system "${CHART}" --version "${VERSION}" --wait --debug -f values.yaml

kubectl get pods -n kube-system | grep kata
