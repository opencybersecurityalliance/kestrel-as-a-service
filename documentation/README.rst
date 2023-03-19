

**minikube start --memory 16000 --cpus 2**
😄  minikube v1.29.0 on Redhat 8.7
✨  Automatically selected the podman driver. Other choices: ssh, none
📌  Using Podman driver with root privileges
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
E0319 00:32:09.022097   44166 cache.go:188] Error downloading kic artifacts:  not yet implemented, see issue #8426
🔥  Creating podman container (CPUs=2, Memory=16000MB) ...
🐳  Preparing Kubernetes v1.26.1 on Docker 20.10.23 ...
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔗  Configuring bridge CNI (Container Networking Interface) ...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🔎  Verifying Kubernetes components...
🌟  Enabled addons: storage-provisioner, default-storageclass

❗  /usr/bin/kubectl is version 1.24.1, which may have incompatibilities with Kubernetes 1.26.1.
    ▪ Want kubectl v1.26.1? Try 'minikube kubectl -- get pods -A'
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
[kpeeples@kestreltest ~]$ minikube addons enable dashboard
💡  dashboard is an addon maintained by Kubernetes. For any concerns contact minikube on GitHub.
You can view the list of minikube maintainers at: https://github.com/kubernetes/minikube/blob/master/OWNERS
    ▪ Using image docker.io/kubernetesui/dashboard:v2.7.0
    ▪ Using image docker.io/kubernetesui/metrics-scraper:v1.0.8
💡  Some dashboard features require the metrics-server addon. To enable all features please run:

	minikube addons enable metrics-server	


🌟  The 'dashboard' addon is enabled

[kpeeples@kestreltest ~]$ minikube addons enable metrics-server
💡  metrics-server is an addon maintained by Kubernetes. For any concerns contact minikube on GitHub.
You can view the list of minikube maintainers at: https://github.com/kubernetes/minikube/blob/master/OWNERS
    ▪ Using image registry.k8s.io/metrics-server/metrics-server:v0.6.2
🌟  The 'metrics-server' addon is enabled


**minikube kubectl -- get pods -A**
NAMESPACE              NAME                                        READY   STATUS                  RESTARTS        AGE
default                continuous-image-puller-dvgf4               0/1     Init:ImagePullBackOff   0 (15d ago)     15d
default                hub-594756b649-knm2x                        1/1     Running                 1 (5m19s ago)   15d
default                proxy-6b86dd54c6-dh9hg                      1/1     Running                 1 (5m19s ago)   15d
default                user-scheduler-75886946b7-k2t5j             1/1     Running                 1 (5m19s ago)   15d
default                user-scheduler-75886946b7-tn64q             1/1     Running                 1 (5m19s ago)   15d
kube-system            coredns-787d4945fb-gnjm6                    1/1     Running                 1 (5m19s ago)   15d
kube-system            etcd-minikube                               1/1     Running                 1 (5m19s ago)   15d
kube-system            kube-apiserver-minikube                     1/1     Running                 1 (5m19s ago)   15d
kube-system            kube-controller-manager-minikube            1/1     Running                 1 (5m19s ago)   15d
kube-system            kube-proxy-7pfmh                            1/1     Running                 1 (5m19s ago)   15d
kube-system            kube-scheduler-minikube                     1/1     Running                 1 (5m19s ago)   15d
kube-system            metrics-server-5f8fcc9bb7-rckzl             1/1     Running                 0               4m39s
kube-system            storage-provisioner                         1/1     Running                 3 (4m26s ago)   15d
kubernetes-dashboard   dashboard-metrics-scraper-5c6664855-pgczt   1/1     Running                 1 (5m19s ago)   15d
kubernetes-dashboard   kubernetes-dashboard-55c4cbbc7c-n7xbj       1/1     Running                 1 (5m19s ago)   15d


helm upgrade --cleanup-on-fail --debug --install kestrel jupyterhub/jupyterhub --namespace kaas --create-namespace --version=2.0 --values config.yaml
.....
  You have successfully installed the official JupyterHub Helm chart!

### Installation info

  - Kubernetes namespace: kaas
  - Helm release name:    kestrel
  - Helm chart version:   2.0.0
  - JupyterHub version:   3.0.0
  - Hub pod packages:     See https://github.com/jupyterhub/zero-to-jupyterhub-k8s/blob/2.0.0/images/hub/requirements.txt

### Followup links

  - Documentation:  https://z2jh.jupyter.org
  - Help forum:     https://discourse.jupyter.org
  - Social chat:    https://gitter.im/jupyterhub/jupyterhub
  - Issue tracking: https://github.com/jupyterhub/zero-to-jupyterhub-k8s/issues

### Post-installation checklist

  - Verify that created Pods enter a Running state:

      kubectl --namespace=kaas get pod

    If a pod is stuck with a Pending or ContainerCreating status, diagnose with:

      kubectl --namespace=kaas describe pod <name of pod>

    If a pod keeps restarting, diagnose with:

      kubectl --namespace=kaas logs --previous <name of pod>

  - Verify an external IP is provided for the k8s Service proxy-public.

      kubectl --namespace=kaas get service proxy-public

    If the external ip remains <pending>, diagnose with:

      kubectl --namespace=kaas describe service proxy-public

  - Verify web based access:

    You have not configured a k8s Ingress resource so you need to access the k8s
    Service proxy-public directly.

    If your computer is outside the k8s cluster, you can port-forward traffic to
    the k8s Service proxy-public with kubectl to access it from your
    computer.

      kubectl --namespace=kaas port-forward service/proxy-public 8080:http

    Try insecure HTTP access: http://localhost:8080


 [kpeeples@kestreltest ~]$ minikube service list
|----------------------|---------------------------|--------------|---------------------------|
|      NAMESPACE       |           NAME            | TARGET PORT  |            URL            |
|----------------------|---------------------------|--------------|---------------------------|
| default              | kubernetes                | No node port |
| kaas                 | hub                       | No node port |
| kaas                 | proxy-api                 | No node port |
| kaas                 | proxy-public              | http/80      | http://192.168.49.2:31504 |
| kube-system          | kube-dns                  | No node port |
| kube-system          | metrics-server            | No node port |
| kubernetes-dashboard | dashboard-metrics-scraper | No node port |
| kubernetes-dashboard | kubernetes-dashboard      | No node port |
|----------------------|---------------------------|--------------|---------------------------|

minikube dashboard

browse - http://192.168.49.2:31504/hub/login