

**minikube start --memory 8192 --cpus 4**
😄  minikube v1.29.0 on Redhat 8.7
✨  Using the podman driver based on existing profile
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
E0319 00:16:19.919972   13529 cache.go:188] Error downloading kic artifacts:  not yet implemented, see issue #8426
🔄  Restarting existing podman container for "minikube" ...
🐳  Preparing Kubernetes v1.26.1 on Docker 20.10.23 ...
🔗  Configuring bridge CNI (Container Networking Interface) ...
🔎  Verifying Kubernetes components...
    ▪ Using image docker.io/kubernetesui/metrics-scraper:v1.0.8
    ▪ Using image docker.io/kubernetesui/dashboard:v2.7.0
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
💡  Some dashboard features require the metrics-server addon. To enable all features please run:

	minikube addons enable metrics-server	


🌟  Enabled addons: storage-provisioner, default-storageclass, dashboard

❗  /usr/bin/kubectl is version 1.24.1, which may have incompatibilities with Kubernetes 1.26.1.
    ▪ Want kubectl v1.26.1? Try 'minikube kubectl -- get pods -A'
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
**minikube addons enable metrics-server**
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

