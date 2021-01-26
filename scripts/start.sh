#!/bin/bash

# setup persistent mount points
echo "Setting up persistent mount points..."

PERSISTENT_PATH=/persistent
declare -a PATHS=(
    "/home"
    "/etc/ssh"
)

for PATH in "${PATHS[@]}"
do
    echo "-> $PATH"
    mv $PATH $PATH-base
    mkdir -p $PATH
    rsync -au --ignore-existing $PATH-base/ $PERSISTENT_PATH$PATH/
    mount --bind $PERSISTENT_PATH$PATH $PATH
done

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