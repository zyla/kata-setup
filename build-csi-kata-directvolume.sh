#!/bin/bash

set -euo pipefail
cd "$(dirname $0)"

# Start registry
kubectl apply -f registry.yaml

echo "Waiting for registry to be available..."
kubectl wait --for=condition=Available deployment/registry
echo "Registry deployment Available."

nerdctl build -t localhost:5000/csi-kata-directvolume ./csi-kata-directvolume-build
kubectl port-forward deployment/registry 5000 &
fwd_pid="$!"
trap 'kill $fwd_pid' EXIT

for n in {1..15}; do
  if curl -s localhost:5000; then
    break
  fi
  sleep 1
done

nerdctl push localhost:5000/csi-kata-directvolume
