# Getting Started with Kestrel as a Service (KaaS)

## Overview

There are multiple automation deployment models that we focus on for installation. This gives flexibility in the install and configuration of KaaS.  We will walk through each of the deployment models as well as location for tutorials to run your first Team Hunt.

The deployment models allow automation from scratch, existing infrastructure or an existing cluster.

## Deployment Models and Steps

There are multiple options available and there are several questions to answer to determine your starting point.

1. Do you have Virtual Machines Running or starting from scratch?
2. Do you have a preference of Operating System?
3. Are you creating a sandbox environment or a production environment?
4. Can the supporting products be installed on your host?

For a small getting started environment either use deployment model 1 or 2.

### Deployment Model 1 - Single User (Developer/Threat Hunter) Container

This is a example of a quick test for a single user, but our objective is to create a shared, collaborative platform.

| Step | Description |
| --- | --- |
| 1 | docker build -t kpeeples/kaas-baseline:latest https://raw.githubusercontent.com/kpeeples/kestrel-as-a-service/main/dockerhub/Dockerfile |
| 2 | Run docker run -d -p 8888:8888 kpeeples/kaas-baseline:latest |
| 3 | Run docker ps |
| 4 | Run docker exec -it <containerid> /bin/bash |
| 5 | Run jupyter server list gives the token to sign on |
| 6 | Browse to http://localhost:8888 and enter token (defaults to http://localhost:8888/lab) |

### Deployment Model 2 - Multi-User Single Node Developer (Many Threat Hunters) Platform (with ansible controller)

 The validated high level steps from scratch for a development team sandbox with Minikube on Ubuntu are:

| Step | Description |
| --- | --- |
| 1 | Install Vagrant from https://developer.hashicorp.com/vagrant/downloads |
| 2 | Install Virtualbox from https://www.virtualbox.org/wiki/Downloads |
| 3 | Install Git from https://git-scm.com/downloads |
| 4 | Clone the repo using `git clone https://github.com/opencybersecurityalliance/kestrel-as-a-service` |
| 5 | Create the virtual machines by running `vagrant up` from the deployment-scripts folder of the cloned working folder. |
| 6 | Connect to the Ansible Controller using `vagrant ssh controller`.Our controller example uses a F38 box, which is hosted on vagrant cloud.  When vagrant up is used it downloads the f38 box from https://app.vagrantup.com/kestrel-deployment/boxes/controller-f38 |
| 7 | From the deployment-scripts folderrun the `controller-setup.sh. Our default example is using the minikube on ubuntu deployment.  Changing the vagrant file config can be done to utilize RHEL and other deployment options.  A delay will occur during the setup controller script as it tries to copy keys to the full node list, regardless of deployment type. |
| 8 | Deploy Kubernetes, supporting projects and KaaS by running the `deploy-minikube.sh` script |
| 9 | Browse to the Kubernetes dashboard and KaaS dashboard.  Make sure their is no firewall blocking the ports. <br>1. http://192.168.50.9:30080 for the jupyterhub console <br>2. http://192.168.50.9:30081 for the kubernetes console |
| 10 | Go to the tutorial folder to start the tutorials |

### Deployment Model 3 - Multi-User Native (Community Supported) Kubernetes Full Cluster (Many Enterprise Threat Hunters) Platform

We will be testing this more before posting the steps.

### Deployment Model 4 - Multi-User Red Hat Openshift (Commercially Supported) Full Cluster (Many Enterprise Threat Hunters) Platform

We will be testing this more before posting the steps.

### Deployment Model 5 - Deploy with Existing Virtual Machines

This deployment model assumes the machines are built with a basic configuration, then deploying the platform on top.  We will be testing this more before posting the steps.

### Deployment Model 6 - Deploy with Existing Container Platform

We will be testing this more before posting the steps.

### Deployment Model 7 - Deploy with Existing Jupyterhub

We will be testing this more before posting the steps.

## Unit Test:

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
