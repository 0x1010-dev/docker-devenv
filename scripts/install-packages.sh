#!/bin/bash

# strict mode
set -euo pipefail

# no feedback
export DEBIAN_FRONTEND=noninteractive

# update & upgrade
apt-get update && apt-get -y upgrade

# install packages, skipping recommendations
apt-get -y install --no-install-recommends $@

# delete cached files
apt-get clean
rm -rf /var/lib/apt/lists/*gr