#!/bin/bash

set -e

echo "=================================================="
echo " Starting DevOpsLab Infrastructure"
echo "=================================================="

# ==================================================
# VM Startup Order
# ==================================================

VMS=(
  "main-server"
  "monitoring-server"
  "k8s-control-plane"
  "k8s-worker-1"
)

# ==================================================
# Start Infrastructure
# ==================================================

for vm in "${VMS[@]}"; do

  VM_PATH="vagrant/${vm}"

  # Skip if Vagrantfile missing
  [ -f "${VM_PATH}/Vagrantfile" ] || continue

  echo ""
  echo "Checking VM: ${vm}"

  cd "${VM_PATH}"

  VM_STATUS=$(vagrant status --machine-readable | grep ",state," | tail -1 | cut -d',' -f4)

  if [ "${VM_STATUS}" = "running" ]; then

    echo "VM already running. Skipping..."

    SKIPPED_VMS+=("${vm}")

  else

    echo "Starting VM..."

    if vagrant up; then

      echo "VM started successfully."

      SUCCESS_VMS+=("${vm}")

    else

      echo "ERROR: Failed to start ${vm}"

      FAILED_VMS+=("${vm}")

    fi

  fi

  cd - > /dev/null

done

echo ""
echo "=================================================="
echo " Infrastructure Startup Summary"
echo "=================================================="

echo ""
echo "SUCCESSFUL:"
for vm in "${SUCCESS_VMS[@]}"; do
  echo "- ${vm}"
done

echo ""
echo "SKIPPED:"
for vm in "${SKIPPED_VMS[@]}"; do
  echo "- ${vm}"
done

echo ""
echo "FAILED:"
for vm in "${FAILED_VMS[@]}"; do
  echo "- ${vm}"
done

echo ""
echo "=================================================="
echo " Infrastructure Startup Completed"
echo "=================================================="

SUCCESS_VMS=()
FAILED_VMS=()
SKIPPED_VMS=()