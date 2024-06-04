#!/bin/bash

# initializes a Kubernetes worker node and joins it to the cluster
# sudo kubeadm join --token $2 --discovery-token-unsafe-skip-ca-verification $1:6443
# sudo kubeadm join 192.168.2.20:6443 --token abcdef.0123456789abcdef --discovery-token-unsafe-skip-ca-verification
