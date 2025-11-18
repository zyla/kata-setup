#!/bin/bash

set -euo pipefail

# Install directly from the official ghcr.io OCI regitry
# update the VERSION X.YY.Z to your needs or just use the latest

export VERSION=3.23.0
export CHART="oci://ghcr.io/kata-containers/kata-deploy-charts/kata-deploy"

helm upgrade --install kata-deploy -n kube-system "${CHART}" --version "${VERSION}" --wait --debug -f values.yaml

kubectl get pods -n kube-system | grep kata
