#!/bin/bash

# =========================================================
# Device Backup Automation
# =========================================================
# Description:
# Generalized example script for automating
# infrastructure configuration backups.
#
# Intended for:
# - network operations
# - infrastructure management
# - configuration auditing
# - operational visibility
#
# NOTE:
# This is a sanitized educational example.
# =========================================================

BACKUP_DIR="/var/backups/network-devices"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p "$BACKUP_DIR"

echo "======================================"
echo " Device Backup Automation"
echo "======================================"

DEVICES=(
  "192.168.1.10"
  "192.168.1.11"
  "192.168.1.12"
)

for DEVICE in "${DEVICES[@]}"
do
  echo ""
  echo "[+] Processing device: $DEVICE"

  OUTPUT_FILE="${BACKUP_DIR}/${DEVICE}_${DATE}.cfg"

  echo "Simulated backup for device $DEVICE" > "$OUTPUT_FILE"

  echo "Backup stored at:"
  echo "$OUTPUT_FILE"
done

echo ""
echo "Backup workflow completed."
