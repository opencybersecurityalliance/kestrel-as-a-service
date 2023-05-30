IMAGE_NAME = "bento/ubuntu-20.04"
N = 1
M = 1

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

#    config.vm.define "nfs" do |nfs|
#        nfs.vm.box = IMAGE_NAME
#        nfs.vm.hostname = "kaas-nfs"
#        nfs.vm.network "private_network", ip: "192.168.50.7"
#        nfs.vm.provider :virtualbox do |vb|
#            vb.name = "kaas-nfs"
#            vb.memory = 2048
#            vb.cpus = 2
#        end
#        nfs.vm.provision "shell", path: "bootstrap.sh"
#    end

    config.vm.define "minikube" do |minikube|
        minikube.vm.box = IMAGE_NAME
        minikube.vm.hostname = "kaas-minikube"
        minikube.vm.hostname = "kaas-minikube"
        config.vm.network "forwarded_port",
          guest: 8080,
          host:  80,
          auto_correct: true
        minikube.vm.network "private_network", ip: "192.168.50.9"
        minikube.vm.provider :virtualbox do |vb|
            vb.name = "minikube"
            vb.memory = 4096
            vb.cpus = 6
        end
        minikube.vm.provision "shell", path: "bootstrap.sh"
    end

 #   (1..M).each do |i|
 #       config.vm.define "master-#{i}" do |master|
 #           master.vm.box = IMAGE_NAME
 #           master.vm.network "private_network", ip: "192.168.50.#{i+9}"
 #           master.vm.hostname = "kaas-master-#{i}"
 #           master.vm.provider :virtualbox do |vb|
 #               vb.name = "kaas-master-#{i}"
 #               vb.memory = 12288
 #               vb.cpus = 4
 #           end
 #           master.vm.provision "shell", path: "bootstrap.sh"
 #       end
 #   end

 #   (1..N).each do |i|
 #       config.vm.define "node-#{i}" do |node|
 #           node.vm.box = IMAGE_NAME
 #           node.vm.network "private_network", ip: "192.168.50.#{i + 12}"
 #           node.vm.hostname = "kaas-node-#{i}"
 #           node.vm.provider :virtualbox do |vb|
 #               vb.name = "kaas-node-#{i}"
 #               vb.memory = 12288
 #               vb.cpus = 4
 #               disk = "local_storage_node#{i}.vdi"
 #               unless File.exist?(disk)
 #                   vb.customize ['createhd', '--filename', disk, '--size', 20 * 1024]
 #               end
 #                   vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk]
 #           end
 #           node.vm.provision "shell", path: "bootstrap.sh"
 #       end
 #   end

    config.vm.define "controller" do |controller|
        controller.vm.box = IMAGE_NAME
        controller.vm.hostname = "kaas-ansible-controller"
        controller.vm.network "private_network", ip: "192.168.50.8"
        controller.vm.provider :virtualbox do |vb|
            vb.name = "ansible-controller"
            vb.memory = 4096
            vb.cpus = 2
        end
        controller.vm.provision "shell", path: "bootstrap.sh"
        controller.vm.provision "file", source: "key_gen.sh", destination: "/home/vagrant/"
        controller.vm.provision "shell", inline: "chmod a+x /home/vagrant/key_gen.sh && su -c '/home/vagrant/key_gen.sh' vagrant"
        controller.vm.provision "file", source: "ansible", destination: "/tmp/ansible"
        controller.vm.provision "shell", inline: "mkdir /ansible"
        controller.vm.provision "shell", inline: "cp -R /tmp/ansible/* /ansible && chown -R vagrant:vagrant /ansible"
    end

end
