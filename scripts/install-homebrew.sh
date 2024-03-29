#!/bin/bash

# locale
localedef -i en_US -f UTF-8 en_US.UTF-8

# linuxbrew user
useradd -m -s /bin/bash linuxbrew
echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

# install homebrew
sudo -u linuxbrew /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
chmod -R g+rwx /home/linuxbrew/.linuxbrew

# add to skel profile
echo "eval \$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" >>/etc/skel/.zprofile
