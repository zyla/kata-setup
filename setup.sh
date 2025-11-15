#!/bin/bash

set -euo pipefail

cd "$(dirname $0)"

sudo apt update
sudo apt install -y jq

curl -sfL https://get.k3s.io | sh -s - server --flannel-backend wireguard-native --write-kubeconfig-mode=644
mkdir -p ~/.kube
ln -sf /etc/rancher/k3s/k3s.yaml ~/.kube/config
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4 | bash

# Install directly from the official ghcr.io OCI regitry
# update the VERSION X.YY.Z to your needs or just use the latest

export VERSION=$(curl -sSL https://api.github.com/repos/kata-containers/kata-containers/releases/latest | jq .tag_name | tr -d '"')
export CHART="oci://ghcr.io/kata-containers/kata-deploy-charts/kata-deploy"

helm install kata-deploy -n kube-system "${CHART}" --version "${VERSION}" --wait --debug -f values.yaml

# See everything you can configure
#helm show values "${CHART}" --version "${VERSION}"

kubectl get pods -n kube-system | grep kata
