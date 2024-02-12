The jupyter hub docker images are at: https://github.com/jupyter/docker-stacks.  We will extend them but unsure at the moment of putting KaaS images there.

At the moment the docker image is getting pushed to - https://hub.docker.com/repository/docker/kpeeples/kaas-baseline/general.  Creating a KaaS organization would be a monthly cost.

A single developer can use a Fedora Workstation VM (ie Fedora Workstation 38) and follow these steps to setup the environment to run the docker container for a single test.

**Setting up the developer test environment:**

NOTE: KaaS environments include single developer container, shared developer minikube, open source k8s, enterprise supported Openshift AI

1. Install the Fedora Workstation VM (ie Fedora-Workstation-Live-x86_64-38-1.6.iso)
2. Run sudo dnf update
3. Run sudo reboot
4. mkdir git in the home directory and change to the directory
5. Run git clone https://github.com/kpeeples/kestrel-as-aservice.git
6. Run sudo dnf install dnf-plugins-core -y
7. Run sudo dnf config-manager --add-repo=https://download.docker.com/linux/fedora/docker-ce.repo
8. Run sudo dnf makecache
9. Run sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
10. Run sudo systemctl start docker
11. Run sudo systemctl enable docker
12. Run sudo systemctl status docker
13. Run sudo docker run hello-world

**Creating the image:**

- Login to dockerhub
$ docker login
Username: 
Password:
Login Succeeded

- Build image locally on the test environment
$ docker build -t kpeeples/kaas-baseline:latest -t kpeeples/kaas-baseline:v1
 sudo docker build -t kpeeples/kaas-baseline:latest -t kpeeples/kaas-baseline:v2 https://raw.githubusercontent.com/kpeeples/kestrel-as-a-service/main/dockerhub/Dockerfile

- Push image to dockerhub
sudo docker push kpeeples/kaas-baseline:v1
sudo docker push kpeeples/kaas-baseline:latest
https://hub.docker.com/repository/docker/kpeeples/kaas-baseline/general

**Testing the container:**

1. Run docker run -d -p 8888:8888 kpeeples/kaas-baseline:latest
2. Run docker ps
3. Run docker exec -it <containerid> /bin/bash
4. Run jupyter server list gives the token to sign on
5. Browse to http://localhost:8888 and enter token (defaults to http://localhost:8888/lab)

To have Kestrel syntax highlighting support, use the Jupyter Notebook URL (http://hostname:8888/tree) instead of Jupyter Lab (http://hostname:8888/lab) for Kestrel huntbooks.

