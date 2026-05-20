#!/bin/bash

set -e

echo "=================================================="
echo " Creating Monitoring Backup..."
echo "=================================================="

BACKUP_DIR="/workspace/backups/monitoring"

TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

mkdir -p "${BACKUP_DIR}"

# ==================================================
# Backup Grafana Volume
# ==================================================

docker run --rm \
  -v grafana_data:/data \
  -v ${BACKUP_DIR}:/backup \
  alpine \
  tar czf /backup/grafana-${TIMESTAMP}.tar.gz -C /data .

# ==================================================
# Backup Prometheus Volume
# ==================================================

docker run --rm \
  -v prometheus_data:/data \
  -v ${BACKUP_DIR}:/backup \
  alpine \
  tar czf /backup/prometheus-${TIMESTAMP}.tar.gz -C /data .

echo "=================================================="
echo " Monitoring Backup Completed"
echo "=================================================="