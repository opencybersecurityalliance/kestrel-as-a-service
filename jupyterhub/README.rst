Quick commands for initial test with kestrel/jupyterhub docker image.

Notes: a pod is created for each user.

Prerequisites:
1. set hostname
hostnamectl set-hostname kestreltest.zerotrust.foundation
2. subscribe
subscription-manager register
3. update packages
sudo dnf update
4. install virtualbox client

Steps (moving commands to ansible)
1. Install config.yaml, helm and minikube to a RHEL VM.
run get_helm.sh
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
sudo rpm -Uvh minikube-latest.x86_64.rpm
2. Install jupyterhub to minikube
   helm upgrade --cleanup-on-fail \
  --install kestrel jupyterhub/jupyterhub \
  --namespace kaas \
  --create-namespace \
  --version=2.0 \
  --values config.yaml
3. Start minikube
minikube start --driver=virtualbox --memory 8192 --cpus 4
4. minikube dashboard

Link References:
https://minikube.sigs.k8s.io/docs/start/
https://kienmn97.medium.com/manually-deploy-jupyterhub-on-kubernetes-for-a-single-machine-dbcd9c9e50a4
https://github.com/jupyter-on-openshift/jupyterhub-quickstart
https://z2jh.jupyter.org/en/stable/

Command References:
minikube addons enable metrics-server
minikube addons enable ingress
minikube addons list
[kpeeples@kestreltest ~]$ kubectl --namespace=kaas get pod
NAME                              READY   STATUS    RESTARTS   AGE
continuous-image-puller-dndb8     1/1     Running   0          51s
hub-85d88cc647-h7bkr              1/1     Running   0          51s
proxy-66b596dd8-4qp44             1/1     Running   0          51s
user-scheduler-869dc56747-7tqzp   1/1     Running   0          51s
user-scheduler-869dc56747-mcfjn   1/1     Running   0          51s
[kpeeples@kestreltest ~]$ kubectl --namespace=kaas get service proxy-public
NAME           TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
proxy-public   LoadBalancer   10.106.98.85   <pending>     80:30698/TCP   72s



