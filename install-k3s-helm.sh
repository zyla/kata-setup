#!/bin/bash

curl -sfL https://get.k3s.io | sh -s - server --flannel-backend wireguard-native --write-kubeconfig-mode=640 --write-kubeconfig-group="$(id -g)"
mkdir -p ~/.kube
ln -sf /etc/rancher/k3s/k3s.yaml ~/.kube/config
./get-helm-4
