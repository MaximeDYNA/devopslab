#!/bin/bash

set -e

echo "=================================================="
echo " Main Server Bootstrap Starting..."
echo "=================================================="

# ==================================================
# Copy Shared Scripts
# ==================================================

cp /workspace/vagrant/shared/scripts/common/packages.sh /tmp/packages.sh
cp /workspace/vagrant/shared/scripts/common/utilities.sh /tmp/utilities.sh
cp /workspace/vagrant/shared/scripts/docker/install-docker.sh /tmp/install-docker.sh
cp /workspace/vagrant/shared/scripts/jenkins/install-jenkins.sh /tmp/install-jenkins.sh
cp /workspace/vagrant/shared/scripts/nginx/install-nginx.sh /tmp/install-nginx.sh
cp /workspace/vagrant/shared/scripts/nginx/configure-nginx.sh /tmp/configure-nginx.sh


# ==================================================
# Set Permissions
# ==================================================

chmod +x /tmp/packages.sh
chmod +x /tmp/utilities.sh
chmod +x /tmp/install-docker.sh
chmod +x /tmp/install-jenkins.sh
chmod +x /tmp/install-nginx.sh
chmod +x /tmp/configure-nginx.sh
# ==================================================
# Load Shared Functions
# ==================================================

source /tmp/packages.sh
source /tmp/utilities.sh

# ==================================================
# System Preparation
# ==================================================

log_info "Updating system packages"

update_system

log_info "Installing common packages"

install_common_packages

# ==================================================
# Docker Installation
# ==================================================

log_info "Installing Docker"

bash /tmp/install-docker.sh

# ==================================================
# Jenkins Installation
# ==================================================

log_info "Installing Jenkins"

bash /tmp/install-jenkins.sh

# ==================================================
# NGINX Installation
# ==================================================

log_info "Installing NGINX"

bash /tmp/install-nginx.sh

# ==================================================
# NGINX Configuration
# ==================================================

log_info "Configuring NGINX"

bash /tmp/configure-nginx.sh



# ==================================================
# Cleanup
# ==================================================

cleanup_packages

# ==================================================
# Completion
# ==================================================

log_info "Main Server Bootstrap Completed Successfully"