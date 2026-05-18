#!/bin/bash

set -e

echo "=================================================="
echo " Monitoring Server Bootstrap Starting..."
echo "=================================================="

# ==================================================
# Copy Shared Scripts
# ==================================================

cp /workspace/vagrant/shared/scripts/common/packages.sh /tmp/packages.sh
cp /workspace/vagrant/shared/scripts/common/utilities.sh /tmp/utilities.sh
cp /workspace/vagrant/shared/scripts/docker/install-docker.sh /tmp/install-docker.sh

# ==================================================
# Set Permissions
# ==================================================

chmod +x /tmp/packages.sh
chmod +x /tmp/utilities.sh
chmod +x /tmp/install-docker.sh
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
# Monitoring Directories
# ==================================================

log_info "Creating monitoring directories"

mkdir -p /opt/monitoring

# ==================================================
# Deploy Monitoring Stack
# ==================================================

log_info "Deploying Monitoring Stack"

bash /workspace/vagrant/shared/scripts/monitoring/deploy-monitoring-stack.sh

# ==================================================
# Cleanup
# ==================================================

cleanup_packages

# ==================================================
# Completion
# ==================================================

log_info "Monitoring Server Bootstrap Completed Successfully"