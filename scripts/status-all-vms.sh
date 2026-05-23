#!/bin/bash

set -e

echo "=================================================="
echo " DevOpsLab Infrastructure Status"
echo "=================================================="

for vm_path in vagrant/*; do

  # Skip if not directory
  [ -d "$vm_path" ] || continue

  # Skip if no Vagrantfile
  [ -f "$vm_path/Vagrantfile" ] || continue

  VM_NAME=$(basename "$vm_path")

  cd "$vm_path"

  VM_STATUS=$(vagrant status --machine-readable | grep ",state," | tail -1 | cut -d',' -f4)

  echo "${VM_NAME}: ${VM_STATUS}"

  cd - > /dev/null

done

echo "=================================================="