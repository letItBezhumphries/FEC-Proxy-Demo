#!/bin/bash

set -x

#install necessary dependencies
sudo apt-get update
sudo apt-get install -y ntpdate curl wget git apt-transport-https ca-certificates vim lvm2 unzip 
# gcc net-tools

# install nginx
sudo apt install -y nginx

# Setup sudo to allow no-password sudo for "proxy-service" group and adding "ubuntu" user
sudo groupadd -r proxy-admin
sudo usermod -a -G proxy-admin ubuntu
sudo cp /etc/sudoers /etc/sudoers.orig
echo "ubuntu ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ubuntu

#installing ssh key
sudo mkdir -p /home/ubuntu/.ssh
sudo chmod 700 /home/ubuntu/.ssh
# sudo cp /tmp/mykey.pub /home/ubuntu/.ssh/authorized_keys
# sudo chmod 600 /home/ubuntu/.ssh/authorized_keys
sudo chown -R ubuntu /home/ubuntu/.ssh
sudo usermod --shell /bin/bash ubuntu

# install LTS nodesource PPA
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# install nodejs
sudo apt-get install nodejs -y

# clone down FEC-Proxy-Demo
sudo -u ubuntu git clone https://github.com/letItBezhumphries/FEC-Proxy-Demo.git

sudo apt-get clean