#!/bin/bash

log_info() {
  echo ""
  echo "[INFO] =================================================="
  echo "[INFO] $1"
  echo "[INFO] =================================================="
  echo ""
}

check_command() {
  command -v "$1" >/dev/null 2>&1
}