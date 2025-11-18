#!/bin/bash

set -euo pipefail
cd "$(dirname $0)"

nerdctl build -t localhost/kata-directvolume:v1.0.19 ./csi-kata-directvolume-build
nerdctl save localhost/kata-directvolume:v1.0.19 -o /tmp/csi-kata-directvolume.tar
sudo k3s ctr -n k8s.io image import /tmp/csi-kata-directvolume.tar
