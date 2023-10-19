# Getting Started with Kestrel as a Service (KaaS) - Project Plan

## Overview

There are multiple automation deployment models that we focused on for usage. This gives flexibility in the install and configuration of KaaS.  We will walk through each of the deployment models and then focus on the benefits of the Kestrel as a Service Model as well as running your first Team Hunt.

The deployment models allow automation from scratch, existing infrastructure or an existing cluster.

## Deployment Models

There are multiple options available as seen in the Mindmap below to show starting at multiple points.  There are several questions to answer to determine your starting point.

1. Do you have Virtual Machines Running or starting from scratch?
2. Do you have a preference of Operating System?
3. Are you creating a sandbox environment or a production environment?
4. Can the supporting products be installed on your host?

Let's start off by showing the general process of starting from scratch before going into the deployment mindmap models.  The validated high level steps from scratch for a development team sandbox with Minikube on Ubuntu are:

| Step | Manual or Auto | Description |
| --- | --- | --- |
| 1 | Manual | Install Vagrant from https://developer.hashicorp.com/vagrant/downloads |
| 2 | Manual | Install Virtualbox from https://www.virtualbox.org/wiki/Downloads |
| 3 | Manual | Install git |
| 4 | Manual | Clone the repo using `git clone https://github.com/opencybersecurityalliance/kestrel-as-a-service` |
| 5 | Auto | Create the virtual machines by running `vagrant up` |
| 6 | Manual | Connect to the Ansible Controller |
| 7 | Auto | Deploy Kubernetes, supporting projects and KaaS by running the `deploy-minikube.sh` script |
| 8 | Manual | Browse to the Kubernetes dashboard and KaaS dashboard |

This is a high level overview but we will go through each option and step in detail.

## Deploy from Scratch for a new environment

The environment is created by using the overview steps above.  To access the 

## Deploy with Existing Virtual Machines

This deployment model assumes the machines are built with a basic configuration.

### Prerequisites

Note the vagrant build does the below automaticallyin the bootstrap.sh file
Ansible is installed on a ansible controller node 
/etc/hosts has been built on all machines
The user that ansible is going to use has been created on the VMs
keygen has been run on the controller node, and public key copied to the nodes
Clone the repo from kaas

## Deploy with Existing Virtual Machine and Kubernetes Cluster



1. Existing Baremetal/VMs

2. New Environment


Curre, ,.nmnn.nm,ntly the testing for milestone 1 is using the nfs, controller, node-1 and master-1 virtual machines with a base Ubuntu, with the addition of Keycloakansible module. Minikube (1 VM) and Fedora are in progress.

Steps to build and test the environment using the Ansible roles defined in the site-kubernetes.yaml.

- Install Virtual Box 
- Install Vagrant 
- Clone Kestrel As a Service - https://github.com/opencybersecurityalliance/kestrel-as-a-service 
- Run vagrant up 
- Run ansible playbook 
-- [local] vagrant ssh controller
-- [controller] cd /ansible
-- [controller] ansible-playbook -i hosts site-kubernetes.yaml 
- Access the Kubernetes Dashboard
-- [master-1] --> kubernetes-dashboard        NodePort    10.102.110.81   <none>        443:31888/TCP   9h
-- [master-1]SECRET_NAME=$(kubectl -n kubernetes-dashboard get serviceaccount admin-user -o jsonpath='{$.secrets[0].name}')
-- [master-1]TOKEN=$(kubectl -n kubernetes-dashboard get secret ${SECRET_NAME} -o jsonpath='{$.data.token}' | base64 -d | sed $'s/$/\\\n/g')
-- [master-1]echo $TOKEN
-- [local]browse to port with master-ip:port, ie https://192.168.50.10:31888/#/login
-- Copy the content from $TOKEN into the token field
- Access the KaaS Dashboard
-- [master-1] kubectl get svc -n kaas --> proxy-public   NodePort    10.107.60.121    <none>        80:30080/TCP   9h
-- [local] browse to http://192.168.50.9:30080

NOTE: 
- /vagrant directory on servers will point to local local workspace
- second drive for local-storage default is located at node-1 for Jupyterhub DB with NFS for user storage space
- kubernetes dashboard and jupyterhub dashboard are exposed outside the Cluster

Unit Test:
1. Kubernetes Master, Kubernetes Node, Ansible Controller, NFS Server Running
2. NFS Server responding
3. Kubernetes dashboard with metric server accessible
4. JupyterHub Dashboard accessible
5. Keycloak Daskboard accessible
6. User pod persistent
7. Postgres Database Running
8. Kestrel Tutorial start to finish
9. Load Test (development/minimum 30 user requirement test and production 100 test) - check requirements for master and node
10. CI/CD pipeline on minikube

Build the single node development environment

2 virtual machines - controller 20.04 minikube - 22.04\
controller - 16gb 8 cpu ansible 2.13
minikube - 32 cpu 32 gb
kaas user ansible controller

Dashboard
 kubectl get svc -n kubernetes-dashboard kubernetes-dashboard -o yaml
kubectl --namespace kubernetes-dashboard patch svc kubernetes-dashboard -p '{"spec": {"type": "NodePort"}}'
minikube dashboard --url &
kubectl proxy --address=0.0.0.0 --accept-hosts='.*'
http://192.168.50.9:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/deployment/kaas/hub?namespace=_all
https://serverfault.com/questions/1095980/connecting-nodeport-in-minikube
https://github.com/kubernetes/minikube/issues/11577
https://devopscube.com/kubernetes-cluster-vagrant/
https://stackoverflow.com/questions/46507766/kubernetes-ingress-running-behind-nginx-reverse-proxy
https://stackoverflow.com/questions/69306648/forward-requests-to-minikube-ip-how-to-access-application-deployed-in-minikube
https://stackoverflow.com/questions/65397050/minikube-does-not-start-on-ubuntu-20-04-lts-exiting-due-to-guest-provision
https://kienmn97.medium.com/manually-deploy-jupyterhub-on-kubernetes-for-a-single-machine-dbcd9c9e50a4

kubectl port-forward --address 0.0.0.0 service/<service-name> 8080:80
kubectl port-forward --address 0.0.0.0 service/kubernetes-dashboard 8080:81 -n kubernetes-dashboard & kubectl port-forward --address 0.0.0.0 service/proxy-public 8081:80 -n kaas &
minikube mount $HOME:/host

kubectl port-forward --address 192.168.50.9 service/kubernetes-dashboard 30081:81


NOTE: change IP to variable instead of static for iptables


sudo bash -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'
sudo vim /etc/sysctl.conf & change net.ipv4.ip_forward = 1
sudo /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
tcpdump

sudo iptables -t nat -I PREROUTING -p tcp -d 192.168.50.9 --dport 30000:32767 -j DNAT --to 192.168.49.2:30000-32767
-t table        table to manipulate (default: `filter')
-I chain [rulenum]  Insert in chain as rulenum (default 1=first)
-p proto   protocol: by number or name, eg. `tcp'
-d address[/mask][...]  destination specification
--dport — Sets the destination port for the packet.
-j target  target for rule (may load target extension)
--to ???????  mapped to to-destination and --to-ports

iptables --table nat --list


1. changed kubernetes-dashboard port from 80 to 81
2. removed nfs server
3. sudo usermod -aG docker $USER && newgrp docker

sudo apt remove python3-openssl
pip3 install pyOpenSSL --upgrade
OR try
apt-get --reinstall install python-apt
apt-get --reinstall install apt-transport-https
apt-get install build-essential libssl-dev libffi-dev python-dev


Jupyterhub


Testing 7/3/2023

create infrastructure ---
run vagrant file
-controller, minikube-ubuntu, minikube-rhel setup
run controller-setup.sh on controller ( installs ansible,copies ssh key to servers, updates host file )
run ansible-test.sh to test ssh connection and ansible-module

create platform ---

run deploy-minikube.sh (change remote_user)