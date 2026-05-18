#!/bin/bash

BACKUP_DIR="/workspace/backups/jenkins"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

echo "Creating Jenkins backup..."

sudo systemctl stop jenkins

sudo tar -czpf \
"${BACKUP_DIR}/jenkins-${TIMESTAMP}.tar.gz" \
/var/lib/jenkins

sudo systemctl start jenkins

echo "Cleaning old backups..."

find "${BACKUP_DIR}" -type f -mtime +7 -delete

echo "Backup completed:"
echo "${BACKUP_DIR}/jenkins-${TIMESTAMP}.tar.gz"
