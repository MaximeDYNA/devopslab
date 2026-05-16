#!/bin/bash

source /tmp/packages.sh
source /tmp/utilities.sh

log_info "Installing NGINX"

# ==================================================
# Check Existing Installation
# ==================================================

if systemctl list-unit-files | grep -q nginx; then

  log_info "NGINX already installed"
  exit 0

fi

# ==================================================
# Install NGINX
# ==================================================

apt-get update -y

apt-get install -y nginx

# ==================================================
# Enable And Start Service
# ==================================================

systemctl enable nginx
systemctl start nginx

# ==================================================
# Validate Service
# ==================================================

systemctl status nginx --no-pager

log_info "NGINX installation completed"