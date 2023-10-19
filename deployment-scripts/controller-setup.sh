sudo dnf install ansible -y -v
ansible-playbook -i inventory bootstrap-playbook.yml -K --connection=local
ansible all -i inventory -m "shell" -a "uptime"
