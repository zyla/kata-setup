#!/bin/bash

set -euo pipefail

cd "$(dirname $0)"

sudo apt update
sudo apt install -y jq

curl -sfL https://get.k3s.io | sh -s - server --flannel-backend wireguard-native --write-kubeconfig-mode=640 --write-kubeconfig-group="$(id -g)"
mkdir -p ~/.kube
ln -sf /etc/rancher/k3s/k3s.yaml ~/.kube/config
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4 | bash

./helm-install.sh

./build-csi-kata-directvolume.sh
