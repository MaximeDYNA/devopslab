#!/bin/bash

set +e

echo "=================================================="
echo " DevOpsLab Infrastructure Health Check"
echo "=================================================="

VMS=(
  "main-server"
  "monitoring-server"
)

# ==================================================
# Main Loop
# ==================================================

for vm in "${VMS[@]}"; do

  VM_PATH="vagrant/${vm}"

  echo ""
  echo "Checking VM: ${vm}"
  echo "--------------------------------------------------"

  cd "${VM_PATH}"

  # ------------------------------------------------
  # VM State
  # ------------------------------------------------

  VM_STATUS=$(vagrant status --machine-readable | grep ",state," | tail -1 | cut -d',' -f4)

  if [ "${VM_STATUS}" != "running" ]; then

    echo "❌ VM not running"

    cd - > /dev/null
    continue

  fi

  echo "✅ VM running"

  # ------------------------------------------------
  # SSH Validation
  # ------------------------------------------------

  if vagrant ssh -c "echo SSH_OK" > /dev/null 2>&1; then

    echo "✅ SSH reachable"

  else

    echo "❌ SSH unreachable"

    cd - > /dev/null
    continue

  fi

  # ------------------------------------------------
  # Docker Validation
  # ------------------------------------------------

  if vagrant ssh -c "docker ps" > /dev/null 2>&1; then

    echo "✅ Docker running"

  else

    echo "❌ Docker unavailable"

  fi

  # ------------------------------------------------
  # Monitoring Services
  # ------------------------------------------------

  if [ "${vm}" = "monitoring-server" ]; then

    if vagrant ssh -c "curl -s http://localhost:9090/-/healthy" > /dev/null 2>&1; then

      echo "✅ Prometheus healthy"

    else

      echo "❌ Prometheus unhealthy"

    fi

    if vagrant ssh -c "curl -s http://localhost:3000/api/health" > /dev/null 2>&1; then

      echo "✅ Grafana healthy"

    else

      echo "❌ Grafana unhealthy"

    fi

  fi

  cd - > /dev/null

done

echo ""
echo "=================================================="
echo " Infrastructure Health Check Completed"
echo "=================================================="