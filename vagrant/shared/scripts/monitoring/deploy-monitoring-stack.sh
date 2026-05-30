#!/bin/bash

set -e

echo "=================================================="
echo " Deploying Monitoring Stack..."
echo "=================================================="

MONITORING_DIR="/workspace/vagrant/shared/monitoring"
PROMETHEUS_CONFIG="${MONITORING_DIR}/prometheus/prometheus.yml"

# ==================================================
# Validate Prometheus Configuration
# ==================================================

if [ ! -f "${PROMETHEUS_CONFIG}" ]; then
  echo ""
  echo "ERROR: Prometheus configuration file not found:"
  echo "${PROMETHEUS_CONFIG}"
  echo ""
  exit 1
fi

echo "Prometheus configuration found."

# ==================================================
# Deploy Monitoring Stack
# ==================================================

cd "${MONITORING_DIR}"

docker compose up -d

echo "=================================================="
echo " Monitoring Stack Deployed Successfully"
echo "=================================================="