#!/bin/bash

tmpdir="$(mktemp -d)"
trap 'rm -rf $tmpdir' EXIT

cd $tmpdir
git clone https://github.com/kutespaces/simple-git-http-server --depth 1

nerdctl build -t localhost/simple-git-http-server:latest ./simple-git-http-server
nerdctl save localhost/simple-git-http-server:latest -o image.tar
sudo k3s ctr -n k8s.io image import image.tar
