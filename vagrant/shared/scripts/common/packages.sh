#!/bin/bash

update_system() {

  apt-get update -y
  apt-get upgrade -y

}

install_common_packages() {

  apt-get install -y \
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

  apt-get autoremove -y
  apt-get clean

}