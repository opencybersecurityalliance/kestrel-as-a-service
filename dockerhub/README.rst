The jupyter hub docker images are at: https://github.com/jupyter/docker-stacks.  We will extend them but unsure at the moment of putting KaaS images there.

At the moment the docker image is getting pushed to - https://hub.docker.com/repository/docker/kpeeples/jupyter-kestrel/general.  Creating a KaaS organization would be a monthly cost.

Creating the image:

- Login to dockerhubusing one of the examples
$ docker login
Username: 
Password:
Login Succeeded
$ docker login --username demo --password example
$ cat password.txt | docker login --username demo --password-stdin
Note: you can use a credential helper - https://docs.docker.com/engine/reference/commandline/login/#credentials-store

- Build image
$ docker build -t kpeeples/kaas-baseline:latest -t kpeeples/kaas-baseline:v1
 sudo docker build -t kpeeples/kaas-baseline:latest -t kpeeples/kaas-baseline:v2 https://raw.githubusercontent.com/kpeeples/kestrel-as-a-service/main/dockerhub/Dockerfile

-Push image
sudo docker push kpeeples/kaas-baseline:v1
sudo docker push kpeeples/kaas-baseline:latest
https://hub.docker.com/repository/docker/kpeeples/kaas-baseline/general

