#!/bin/bash

set -e

echo "=================================================="
echo " Stopping DevOpsLab Infrastructure"
echo "=================================================="

for vm_path in vagrant/*; do

  # Skip if not directory
  [ -d "$vm_path" ] || continue

  # Skip if no Vagrantfile
  [ -f "$vm_path/Vagrantfile" ] || continue

  VM_NAME=$(basename "$vm_path")

  echo ""
  echo "Checking VM: ${VM_NAME}"

  cd "$vm_path"

  VM_STATUS=$(vagrant status --machine-readable | grep ",state," | tail -1 | cut -d',' -f4)

  if [ "$VM_STATUS" = "running" ]; then

    echo "Stopping VM..."

    vagrant halt

  else

    echo "VM already stopped. Skipping..."

  fi

  cd - > /dev/null

done

echo ""
echo "=================================================="
echo " Infrastructure Shutdown Completed"
echo "=================================================="