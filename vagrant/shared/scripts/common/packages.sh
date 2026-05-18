#!/bin/bash

set -euo pipefail

update_system() {

  echo "[INFO] Configuring APT to use IPv4..."

  cat > /etc/apt/apt.conf.d/99force-ipv4 <<EOF
Acquire::ForceIPv4 "true";
EOF

  echo "[INFO] Updating package index..."
  apt-get update -y

  echo "[INFO] Upgrading installed packages..."
  DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

}

install_common_packages() {

  echo "[INFO] Installing common packages..."

  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    wget \
    unzip \
    git \
    vim \
    nano \
    net-tools \
    ca-certificates \
    gnupg \
    lsb-release \
    apt-transport-https \
    software-properties-common \
    build-essential \
    jq

}

cleanup_packages() {

  echo "[INFO] Cleaning package cache..."

  apt-get autoremove -y
  apt-get clean

}

main() {

  update_system
  install_common_packages
  cleanup_packages

  echo "[INFO] Common packages installation completed."

}

main "$@"