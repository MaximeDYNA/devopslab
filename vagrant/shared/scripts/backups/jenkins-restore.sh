#!/bin/bash

BACKUP_DIR="/workspace/backups/jenkins"

LATEST_BACKUP=$(ls -t ${BACKUP_DIR}/jenkins-*.tar.gz | head -n 1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "No backup found!"
    exit 1
fi

echo "Stopping Jenkins..."
sudo systemctl stop jenkins

echo "Cleaning current Jenkins data..."
sudo rm -rf /var/lib/jenkins/*

echo "Restoring backup..."
sudo tar -xzf "$LATEST_BACKUP" -C /

echo "Fixing permissions..."
sudo chown -R jenkins:jenkins /var/lib/jenkins

echo "Starting Jenkins..."
sudo systemctl start jenkins

echo "Restore completed successfully!"