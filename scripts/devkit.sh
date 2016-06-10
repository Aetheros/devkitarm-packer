#!/bin/bash
apt-get install -y git mercurial subversion vim curl wget screen automake autoconf libtool cmake

echo "export DEVKITPRO=/home/vagrant/devkitPro" >> ~/.bashrc
echo "export DEVKITARM=/home/vagrant/devkitPro/devkitARM" >> ~/.bashrc
echo "export PATH=$PATH:/home/vagrant/devkitPro/devkitARM/bin" >> ~/.bashrc
source ~/.bashrc

cd /usr/bin
wget http://$HTTPSERV:$HTTPPORT/update-devkit
wget http://$HTTPSERV:$HTTPPORT/update-portlibs
wget http://$HTTPSERV:$HTTPPORT/update-sflibs

chmod a+x update-devkit update-portlibs update-sflibs

update-devkit
update-portlibs
update-sflibs

echo "chowning all files in vagrant folder"

chown -R vagrant:vagrant /home/vagrant/

# Set up sudo
echo "%vagrant ALL=NOPASSWD:ALL" > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# Setup sudo to allow no-password sudo for "sudo"
usermod -a -G sudo vagrant