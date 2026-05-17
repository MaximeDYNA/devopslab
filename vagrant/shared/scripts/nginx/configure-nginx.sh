#!/bin/bash

source /tmp/packages.sh
source /tmp/utilities.sh

log_info "Configuring NGINX Reverse Proxy"

# ==================================================
# Copy Jenkins Configuration
# ==================================================

cp /workspace/vagrant/shared/configs/nginx/jenkins.conf \
   /etc/nginx/sites-available/jenkins

# ==================================================
# Enable Jenkins Site
# ==================================================

ln -sf /etc/nginx/sites-available/jenkins \
       /etc/nginx/sites-enabled/jenkins

# ==================================================
# Remove Default Site
# ==================================================

rm -f /etc/nginx/sites-enabled/default

# ==================================================
# Validate Configuration
# ==================================================

nginx -t

# ==================================================
# Reload NGINX
# ==================================================

systemctl reload nginx

log_info "NGINX reverse proxy configured successfully"
