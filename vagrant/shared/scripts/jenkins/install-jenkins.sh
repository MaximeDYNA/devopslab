#!/bin/bash

source /tmp/packages.sh
source /tmp/utilities.sh

log_info "Installing Jenkins"

if systemctl list-unit-files | grep -q jenkins; then

  log_info "Jenkins already installed"
  exit 0

fi

# ==================================================
# Install Dependencies
# ==================================================

apt-get update -y

apt-get install -y \
  openjdk-17-jdk \
  fontconfig \
  curl \
  wget

# ==================================================
# Download Jenkins Package
# ==================================================

wget -O /tmp/jenkins.deb \
  https://pkg.jenkins.io/debian-stable/binary/jenkins_2.504.3_all.deb

# ==================================================
# Install Jenkins Package
# ==================================================

dpkg -i /tmp/jenkins.deb || true

# ==================================================
# Fix Missing Dependencies
# ==================================================

apt-get install -f -y

# ==================================================
# Enable Jenkins
# ==================================================

systemctl daemon-reload

systemctl enable jenkins
systemctl start jenkins

# ==================================================
# Validate Service
# ==================================================

systemctl status jenkins --no-pager

log_info "Jenkins installation completed"