dir="$(realpath $(dirname $0))"
limactl create --name=k3s template:ubuntu-22.04 --mount-only "$dir"
limactl shell --start k3s "$dir/setup.sh"
