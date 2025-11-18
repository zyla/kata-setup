#!/bin/bash

set -euo pipefail
set -x

cd "$(dirname $0)"

./install-k3s-helm.sh
./install-kata.sh
./build-csi-kata-directvolume.sh
./install-csi-kata-directvolume.sh
