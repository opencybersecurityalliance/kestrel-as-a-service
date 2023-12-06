echo "Make sure to update the minikubes:children inventory to 1 - ubuntun, 2 - rhel or both (minikube1 and minikube2) depending on what you built for VMs"
ansible-playbook -i inventory ../ansible/site-minikube.yaml -vvv
