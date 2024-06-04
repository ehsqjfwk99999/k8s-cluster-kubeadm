# k8s Cluster using Vagrant Kubeadm

Setup K8s cluster using Vagrant and kubeadm.

## Configuration
- Node configuration : 1 master + 3 worker
- Provisioning : Vagrant + VirtualBox
- OS : Ubuntu 20.04.3 LTS
- K8s built tool : kubeadm
- CNI : Flannel

## Versions
- 
| Element | Version |
|:------:|:-------:|
| Virtual Box | 6.1.30 |
| Vagrant | 2.2.19 |
| Vagrant box | ubuntu/focal64 v20220208.0.0 (fixed) |
| Ubuntu | 20.04.3 LTS (fixed) |
| Docker | 20.10.12 (fixed) |
| kubelet | 1.23.3-00 (fixed) |
| kubeadm | 1.23.3-00 (fixed) |
| kubectl | 1.23.3-00 (fixed) |
| Flannel | ? (fixed) |

## Todos
- [ ] Why '/etc/hosts' is needed for node internal-ip.

https://kubernetes.io/docs/setup/production-environment/container-runtimes/
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
https://kubernetes.io/docs/setup/production-environment/container-runtimes/
