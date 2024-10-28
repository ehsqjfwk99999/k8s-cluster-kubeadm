# k8s Cluster using Vagrant Kubeadm

Setup K8s cluster using Vagrant and kubeadm.

## Configuration
- Node configuration : 1 master + 3 worker
- Provisioning : Vagrant + VirtualBox
- OS : Ubuntu 20.04.3 LTS
- K8s built tool : kubeadm
- CNI : Flannel

## Versions
| Element | Version |
|:------:|:-------:|
| Virtual Box     | 7.0.20 |
| Vagrant         | 2.4.1 |
| OS(Vagrant box) | ubuntu/jammy64 (fixed) |
| Ubuntu          | 20.04.3 LTS (fixed) |
| containerd      | 1.7.12-0ubuntu2~22.04.1 (fixed) |
| kubelet         | 1.31.2-1.1 (fixed) |
| kubeadm         | 1.31.2-1.1 (fixed) |
| kubectl         | 1.31.2-1.1 (fixed) |
| Flannel         | 0.26.0 (fixed) |

## Key Points
- `containerd` needs systemd for cgroup driver
- Flannel ...
    - needs `br_netfilter` module
    - needs to use the second interface(`enp0s8`), not first one(`enp0s3`)
