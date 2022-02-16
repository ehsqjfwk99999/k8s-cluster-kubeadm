#!/usr/bin/env bash

# install Docker
curl -fsSL https://get.docker.com | VERSION=$1 sh
# change dockers' cgroup driver to systemd and restart Docker server
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
service docker restart

# install kubelet, kubeadm and kubectl
apt-get update
apt-get install -y apt-transport-https ca-certificates curl
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet=$2 kubeadm=$2 kubectl=$2
apt-mark hold kubelet kubeadm kubectl
