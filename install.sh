#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# # install Docker
# curl -fsSL https://get.docker.com | VERSION=$1 sh
# # change dockers' cgroup driver to systemd and restart Docker server
# cat <<EOF | sudo tee /etc/docker/daemon.json
# {
#   "exec-opts": ["native.cgroupdriver=systemd"]
# }
# EOF
# service docker restart

# # install kubelet, kubeadm and kubectl
# apt-get update
# apt-get install -y apt-transport-https ca-certificates curl
# curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
# echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
# apt-get update
# apt-get install -y kubelet=$2 kubeadm=$2 kubectl=$2
# apt-mark hold kubelet kubeadm kubectl

# install containerd
# sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
# echo \
#     "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
#   $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
#     sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
# sudo apt-get update
# sudo apt install -y containerd.io

apt update
apt install -y containerd
mkdir -p /etc/containerd
containerd config default >/etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
systemctl restart containerd

# install kubelet, kubeadm and kubectl
apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
apt-get install -y apt-transport-https ca-certificates curl gpg
# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
# sudo systemctl enable --now kubelet
