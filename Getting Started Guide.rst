**Building the KaaS Environment** 

Currently the testing for milestone 1 is using the nfs, controller, node-1 and master-1 virtual machines with a base Ubuntu, with the addition of Keycloakansible module. Minikube (1 VM) and Fedora are in progress.

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
-- [local] browse to http://192.168.50.10:30080

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

