#!/bin/bash

set -e

echo "=================================================="
echo " Kubernetes Worker Bootstrap"
echo "=================================================="

# ==================================================
# System Update
# ==================================================

echo ""
echo "[INFO] Updating system packages..."

apt-get update -y

# ==================================================
# Base Packages
# ==================================================

echo ""
echo "[INFO] Installing base packages..."

apt-get install -y \
  curl \
  wget \
  vim \
  git \
  net-tools \
  apt-transport-https \
  ca-certificates \
  gnupg \
  lsb-release

# ==================================================
# Disable Swap
# ==================================================

echo ""
echo "[INFO] Disabling swap..."

swapoff -a

sed -i '/swap.img/d' /etc/fstab
rm -f /swap.img

# ==================================================
# Kernel Modules
# ==================================================

echo ""
echo "[INFO] Configuring kernel modules..."

cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

# ==================================================
# Sysctl Configuration
# ==================================================

echo ""
echo "[INFO] Configuring sysctl settings..."

cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF

sysctl --system

# ==================================================
# Install Containerd
# ==================================================

echo ""
echo "[INFO] Installing containerd..."

apt-get install -y containerd

mkdir -p /etc/containerd

containerd config default | tee /etc/containerd/config.toml

sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

systemctl restart containerd
systemctl enable containerd

# ==================================================
# Add Kubernetes Repository
# ==================================================

echo ""
echo "[INFO] Adding Kubernetes repository..."

mkdir -p /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | \
gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | \
tee /etc/apt/sources.list.d/kubernetes.list

apt-get update -y

# ==================================================
# Install Kubernetes Components
# ==================================================

echo ""
echo "[INFO] Installing Kubernetes components..."

apt-get install -y \
  kubelet \
  kubeadm

apt-mark hold kubelet kubeadm

systemctl enable kubelet

echo ""
echo "=================================================="
echo " Kubernetes Worker Preparation Completed"
echo "=================================================="