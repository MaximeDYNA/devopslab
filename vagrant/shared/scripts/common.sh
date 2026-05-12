#!/bin/bash

echo "==============================="
echo "Updating Ubuntu"
echo "==============================="

sudo apt update -y
sudo apt upgrade -y

echo "==============================="
echo "Installing common packages"
echo "==============================="

sudo apt install -y \
curl \
wget \
git \
vim \
nano \
htop \
tree \
net-tools \
unzip \
ca-certificates \
gnupg \
lsb-release
