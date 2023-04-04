Install Vagrant, Virtualbox
Create all the necessary files and directories
ansible.cfg
playbook.yml
hosts
insecure_private_key
Vagrant file
Test

To successfully connect to virtual machines you will need insecure_private_key. You can create it by invoking
command:$ vagrant init inside vagrant directory. It will create insecure_private_key inside your physical machine
in HOME_DIRECTORY/.vagrant.d. Copy it to ansible folder.