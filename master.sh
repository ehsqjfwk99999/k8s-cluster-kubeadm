#!/usr/bin/env bash

# set up the Kubernetes control plane
sudo kubeadm init --token $2 --token-ttl 0 --apiserver-advertise-address=$1 --pod-network-cidr=10.244.0.0/16

# make kubectl work for non-root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# install a CNI(Flannel)
kubectl apply -f kube-flannel.yaml
rm kube-flannel.yaml

# add bash configurations
curl https://raw.githubusercontent.com/ehsqjfwk99999/config-files/main/.bashrc >>/home/vagrant/.bashrc
