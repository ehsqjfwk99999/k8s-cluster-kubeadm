#!/bin/bash

## set up the Kubernetes control plane by kubeadm
## https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/
## '--pod-network-cidr' from Flannel
sudo kubeadm init --apiserver-advertise-address=$1 --token=$2 --token-ttl=0 --pod-network-cidr=$3

# make kubectl work for non-root user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

## install a CNI(Flannel)
## https://kubernetes.io/docs/concepts/cluster-administration/addons/#networking-and-network-policy
## https://github.com/flannel-io/flannel?tab=readme-ov-file#deploying-flannel-manually
wget -q https://github.com/flannel-io/flannel/releases/download/v0.26.0/kube-flannel.yml
sed -i '/        - --kube-subnet-mgr/a\        - --iface=enp0s8' kube-flannel.yml
kubectl apply -f kube-flannel.yml
sleep 5

## download & install
# add bash configurations
curl https://raw.githubusercontent.com/ehsqjfwk99999/config-files/main/.bashrc >>/home/vagrant/.bashrc
# install k9s
wget -q https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_linux_amd64.deb
sudo dpkg -i k9s_linux_amd64.deb
# download example NGINX deployment yaml
wget -q https://gist.githubusercontent.com/ehsqjfwk99999/b94c0a2578594fe1ad75d17c1458cff9/raw/310c2265ed222aa7a87cd228a856e1ceb9768d18/nginx-deployment-clusterip-example.yaml
