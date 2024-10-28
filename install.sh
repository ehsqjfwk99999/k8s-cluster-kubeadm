#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

## install containerd
## https://kubernetes.io/docs/setup/production-environment/container-runtimes/
## https://kubernetes.io/docs/setup/production-environment/container-runtimes/#cgroup-drivers
## https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd
## https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd-systemd
apt update
apt install -y containerd=$1
mkdir -p /etc/containerd
containerd config default >/etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
systemctl restart containerd

## install kubelet, kubeadm and kubectl
## https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
apt-get install -y apt-transport-https ca-certificates curl gpg
# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v$2/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v$2/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet=$3 kubeadm=$3 kubectl=$3
apt-mark hold kubelet kubeadm kubectl
# sudo systemctl enable --now kubelet
