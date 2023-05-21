**Steps to Build Environment** 

- Install Virtual Box 
- Install Vagrant 
- Install Ansible 
- Clone Kestrel As a Service - https://github.com/opencybersecurityalliance/kestrel-as-a-service 
- Determine the OS (ie Ubuntu, Fedora) and Cluster (ie crc, minikube, kubernetes) 
- Run vagrant up 
-- Setup the extra drive for sc/pv/pvc
-- vagrant ssh node-1
-- vagrant@kaas-node-1:~$ sudo fdisk /dev/sdb, select n and defaults, then w to write
-- sudo mkfs.ext4 /dev/sdb
-- sudo mkdir /mnt/local-storage && sudo mount /dev/sdb /mnt/local-storage
-- ll /mnt/local-storage
- Run vagrant provision or ansible playbook 
-- vagrant ssh controller
--  cd /ansible
-- ansible-playbook -i hosts site-kubernetes.yaml 
- Access the Kubernetes Dashboard, using the kubeadmin 
-- kubectl get svc -n kubernetes-dashboard
-- SECRET_NAME=$(kubectl -n kubernetes-dashboard get serviceaccount admin-user -o jsonpath='{$.secrets[0].name}')
-- TOKEN=$(kubectl -n kubernetes-dashboard get secret ${SECRET_NAME} -o jsonpath='{$.data.token}' | base64 -d | sed $'s/$/\\\n/g')
-- echo $TOKEN
-- browse to port with master-ip:port, ie https://192.168.50.10:30672/#/login
-- Copy the content from $TOKEN into the toekn field
- Access the KaaS Dashboard, using a SSO User 

NOTE: 
/vagrant directory on servers will point to local local workspace
second drive for local-storage default is located at local workspace
kubernetes dashboard and jupyterhub dashboard are exposed outside the Cluster
