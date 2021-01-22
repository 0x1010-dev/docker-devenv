#!/bin/bash

# sync base home with mounted home
mv /home /home-base
ln -s /home-persistent /home
rsync -qavx /home-base/ /home-persistent/

# setup password
USER_PASSWORD=`pwgen -c -n -1 12`
echo "user:$USER_PASSWORD" | chpasswd

echo "[ SSH Login Credentials ]"
echo "user: $USER_PASSWORD"

# execute sshd
supervisord -n