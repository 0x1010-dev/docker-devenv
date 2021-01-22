#!/bin/bash

# setup password
USER_PASSWORD=`pwgen -c -n -1 12`
echo "user:$USER_PASSWORD" | chpasswd

echo "┌─╢ SSH Login ╟──────┐"
echo "│ user: peePhaex8zee │"
echo "└────────────────────┘"

supervisord -n