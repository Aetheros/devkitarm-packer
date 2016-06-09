#!/bin/bash
#
# Setup the the box. This runs as root

apt-get -y update

apt-get -y install curl

# You can install anything you need here.

apt-get -y install gpp

apt-get -y install make

apt-get -y install automake

apt-get -y install autoconf

apt-get -y upgrade