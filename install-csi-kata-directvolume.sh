#!/bin/bash

set -euo pipefail

if [ ! -d ./kata-containers ]; then
  git clone https://github.com/kata-containers/kata-containers -b 3.23.0 --depth 1
fi

