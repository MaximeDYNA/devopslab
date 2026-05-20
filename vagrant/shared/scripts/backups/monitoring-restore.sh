#!/bin/bash

set -e

echo "=================================================="
echo " Restoring Monitoring Backup..."
echo "=================================================="

BACKUP_DIR="/workspace/backups/monitoring"

# ==================================================
# Locate Latest Backups
# ==================================================

LATEST_GRAFANA=$(ls -t ${BACKUP_DIR}/grafana-*.tar.gz | head -n 1)

LATEST_PROMETHEUS=$(ls -t ${BACKUP_DIR}/prometheus-*.tar.gz | head -n 1)

echo "Using Grafana backup:"
echo "${LATEST_GRAFANA}"

echo "Using Prometheus backup:"
echo "${LATEST_PROMETHEUS}"

# ==================================================
# Restore Grafana Volume
# ==================================================

docker run --rm \
  -v grafana_data:/data \
  -v ${BACKUP_DIR}:/backup \
  alpine \
  sh -c "rm -rf /data/* && tar xzf /backup/$(basename ${LATEST_GRAFANA}) -C /data"

# ==================================================
# Restore Prometheus Volume
# ==================================================

docker run --rm \
  -v prometheus_data:/data \
  -v ${BACKUP_DIR}:/backup \
  alpine \
  sh -c "rm -rf /data/* && tar xzf /backup/$(basename ${LATEST_PROMETHEUS}) -C /data"

echo "=================================================="
echo " Monitoring Restore Completed"
echo "=================================================="