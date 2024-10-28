#!/bin/bash

## initializes a Kubernetes worker node and joins it to the cluster
## https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-join/
sudo kubeadm join --token $2 --discovery-token-unsafe-skip-ca-verification $1:6443
