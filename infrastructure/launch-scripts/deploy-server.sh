#!/bin/bash

set -x

# set npm config permissions
sudo -E chown -R ubuntu:ubuntu /home/ubuntu/.config

# Create the $HOME directory
echo "export HOME=/home/ubuntu" >> /home/ubuntu/.profile

MYIP=$(ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2)