# -*- mode: ruby -*-
# vi: set ft=ruby :

N_WORKER = 1
cp_node_ip = "192.168.2.20"
worker_ip = Array.new(N_WORKER) { |i| "192.168.2.2#{i+1}"}
token = "abcdef.0123456789abcdef"
pod_network_cidr = "10.244.0.0/16"

k8s_v = "1.31.2-1.1"
ctrd_v = "1.7.12-0ubuntu2~22.04.1"

Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/jammy64" # ubuntu 22.04
  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  ## Control Plane
  config.vm.define "cp" do |cp|
    cp.vm.hostname = "k8s-cp"
    cp.vm.network "private_network", ip: cp_node_ip
    cp.vm.network "public_network", bridge: "Realtek PCIe GbE Family Controller"
    cp.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "k8s-cp"
      vb.cpus = 4
      vb.memory = "4096"
      vb.customize ["modifyvm", :id, "--groups", "/K8s Cluster"]
    end
    cp.vm.provision "shell", path: "config.sh", args: [N_WORKER, cp_node_ip]
    cp.vm.provision "shell", path: "install.sh", args: [ctrd_v, k8s_v[0..3], k8s_v]
    cp.vm.provision "shell", path: "control_plane.sh", privileged: false, args: [cp_node_ip, token, pod_network_cidr]
  end

  ## Worker Nodes
  (1..N_WORKER).each do |i|
    config.vm.define "w-#{i}" do |wn|
      wn.vm.hostname = "k8s-w#{i}"
      wn.vm.network "private_network", ip: worker_ip[i-1]
      wn.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.name = "k8s-w#{i}"
        vb.cpus = 2
        vb.memory = "2048"
        vb.customize ["modifyvm", :id, "--groups", "/K8s Cluster"]
      end
      wn.vm.provision "shell", path: "config.sh", args: [N_WORKER, cp_node_ip]
      wn.vm.provision "shell", path: "install.sh", args: [ctrd_v, k8s_v[0..3], k8s_v]
      wn.vm.provision "shell", path: "worker_node.sh", privileged: false, args: [cp_node_ip, token]
    end
  end

end
