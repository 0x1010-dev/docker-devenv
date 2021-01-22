#!/bin/bash

# strict mode
set -euo pipefail

# no feedback
export DEBIAN_FRONTEND=noninteractive

# update & upgrade
apt-get update && apt-get -y upgrade

# install packages, skipping recommendations
apt-get -y install --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# add docker gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# setup stable repo
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# install docker
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io

# delete cached files
apt-get clean
rm -rf /var/lib/apt/lists/*gr