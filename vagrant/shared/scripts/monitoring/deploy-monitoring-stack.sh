#!/bin/bash

set -e

echo "=================================================="
echo " Deploying Monitoring Stack..."
echo "=================================================="

MONITORING_DIR="/workspace/vagrant/shared/monitoring"

cd "${MONITORING_DIR}"

docker compose up -d

echo "=================================================="
echo " Monitoring Stack Deployed Successfully"
echo "=================================================="