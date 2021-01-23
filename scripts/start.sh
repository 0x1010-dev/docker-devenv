#!/bin/bash

# setting persistent home
echo "Binding /home-persistent to /home..."
mv /home /home-base
mkdir home
mount --bind /home-persistent /home

# syncing persistent home with base
echo "Syncing with /home-base..."
rsync -qavx /home-base/ /home-persistent/

# add to docker group
groupadd -g $(stat -c '%g' /var/run/docker.sock) docker
usermod -aG docker user

# setup password
USER_PASSWORD=`pwgen -c -n -1 12`
echo "user:$USER_PASSWORD" | chpasswd

echo "[ SSH Login Credentials ]"
echo "user: $USER_PASSWORD"

# execute sshd
supervisord -n