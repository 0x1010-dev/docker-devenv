#!/bin/bash

# setup persistent mount points
echo "Setting up persistent mount points..."

PERSISTENT_PATH=/persistent
declare -a PATHS=(
    "/home"
    "/etc/ssh"
)

for THIS in "${PATHS[@]}"
do
    echo "-> $THIS"
    mv $THIS $THIS-base
    mkdir -p $THIS $PERSISTENT_PATH$THIS
    rsync -au --ignore-existing $THIS-base/ $PERSISTENT_PATH$THIS/
    mount --bind $PERSISTENT_PATH$THIS $THIS
done

# add to docker group
groupadd -g $(stat -c '%g' /var/run/docker.sock) docker
usermod -aG docker user

# setup password
USER_PASSWORD=`pwgen -c -n -1 12`
echo "user:$USER_PASSWORD" | chpasswd

echo "[ SSH Login Credentials ]"
echo "user: $USER_PASSWORD"

# x11 forwarding
echo "XAUTHORITY=/tmp/.Xauthority"

# execute sshd
supervisord -n
