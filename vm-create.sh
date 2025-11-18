#!/bin/bash
set -euo pipefail
dir="$(realpath $(dirname $0))"

vm_name="${1:-k3s}"

limactl create --name="$vm_name" template:ubuntu-22.04 --mount-only "$dir" --memory 16
limactl shell --start "$vm_name" "$dir/setup.sh"
