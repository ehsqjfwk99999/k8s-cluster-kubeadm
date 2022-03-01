# -*- mode: ruby -*-
# vi: set ft=ruby :

N = 2
master_ip = "192.168.2.20"
worker_ip = Array.new(N) { |i| "192.168.2.2#{i+1}"}
pod_network_addr = "10.244.0.0/16"
token = "abcdef.0123456789abcdef"

k8s_v = "1.23.3-00"
docker_v = "20.10.12"

Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/focal64"
  config.vm.box_version = "20220208.0.0"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  ### Master Node ###

  config.vm.define "master" do |master|
    master.vm.hostname = "k8s-m"
    master.vm.network "private_network", ip: master_ip
    master.vm.network "public_network", bridge: "Realtek PCIe GbE Family Controller"
    master.vm.provider "virtualbox" do |vb|    
      vb.gui = true     
      vb.name = "k8s-m" 
      vb.cpus = 4       
      vb.memory = "4096"
      vb.customize ["modifyvm", :id, "--groups", "/k8s-cluster"]
    end
    master.vm.provision "file", source: "./kube-flannel.yaml", destination: "~/kube-flannel.yaml"
    master.vm.provision "shell", path: "config.sh", args: [N, master_ip]
    master.vm.provision "shell", path: "install.sh", args: [docker_v, k8s_v]
    master.vm.provision "shell", path: "master.sh", privileged: false, args: [master_ip, token, pod_network_addr]
  end

  ### Worker Nodes ###
  
  (1..N).each do |i|
    config.vm.define "worker-#{i}" do |worker|
      worker.vm.hostname = "k8s-w#{i}"
      worker.vm.network "private_network", ip: worker_ip[i-1]
      worker.vm.provider "virtualbox" do |vb|    
        vb.gui = true        
        vb.name = "k8s-w#{i}"
        vb.cpus = 2          
        vb.memory = "2048"   
        vb.customize ["modifyvm", :id, "--groups", "/k8s-cluster"]
      end
      worker.vm.provision "shell", path: "config.sh", args: [N, master_ip]
      worker.vm.provision "shell", path: "install.sh", args: [docker_v, k8s_v]
      worker.vm.provision "shell", path: "worker.sh", privileged: false, args: [master_ip, token]
    end
  end

end

