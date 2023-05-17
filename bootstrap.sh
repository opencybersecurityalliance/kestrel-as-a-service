#!/usr/bin/env bash

# vagrant by default creates its own keypair for all the machines. Password based authentication will be disabled by default and enabling it so password based auth can be done.

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Supressing the banner message everytime you connect to the vagrant box.

touch /home/vagrant/.hushlogin

# Updating the hosts file for all the 3 nodes with the IP given in vagrantfile

echo -e "192.168.50.8 controller\n192.168.50.9 minikube\n192.168.50.10 kaas-master-1\n192.168.50.13 kaas-node-1" >> /etc/hosts

# Installing necessary packages 

sudo apt update && sudo apt -y install curl wget net-tools iputils-ping python3-pip sshpass

# Install ansible using pip only in controller node
if [[ $(hostname) = "kaas-ansible-controller" ]]; then
  sudo pip3 install ansible
fi
