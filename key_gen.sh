#!/usr/bin/env bash

# THIS SCRIPT WILL CREATE SSH KEYPAIR AND DISTRIBUTE ACROSS ALL NODES

ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""

# LOOPING THROUGH AND DISTRIBUTING THE KEY

for val in kaas-ansible-controller minikube kaas-master-1 kaas-node-1 kaas-nfs; do
        echo "-------------------- COPYING KEY TO ${val^^} NODE ------------------------------"
        sshpass -p 'vagrant' ssh-copy-id -o "StrictHostKeyChecking=no" vagrant@$val
done

# CREATE THE INVENTORY FILE

PROJECT_DIRECTORY="/home/vagrant/ansible_project/"

mkdir -p $PROJECT_DIRECTORY
cd $PROJECT_DIRECTORY

# Creating the inventory file for allnodes to run some adhoc command.

echo -e "kaas-ansible-controller\n\n[ubuntu0]\nminikube\n\n[ubuntu1]\nkaas-master-1\n\n[ubuntu2]\nkaas-node-1\n\n[ubuntu3]\nkaas-nfs" > inventory
echo -e "[defaults]\ninventory = inventory" > ansible.cfg
echo -e "-------------------- RUNNING ANSBILE ADHOC COMMAND - UPTIME ------------------------------"
echo

# running adhoc command to see if everything is fine

ansible all -i inventory -m "shell" -a "uptime"
echo