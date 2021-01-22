#!/bin/bash

# setup password
USER_PASSWORD=`pwgen -c -n -1 12`
echo "user:$USER_PASSWORD" | chpasswd

echo "[ SSH Login Credentials ]"
echo "user: $USER_PASSWORD"

# sync base home with mounted home
mv /home /home-base
ln -s /home-persistent /home
rsync -avx --delete /home-base /home-persistent

# execute sshd
supervisord -n