#!/usr/bin/env bash

# initializes a Kubernetes worker node and joins it to the cluster
sudo kubeadm join --token $2 --discovery-token-unsafe-skip-ca-verification $1:6443
