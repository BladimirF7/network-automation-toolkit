#!/bin/bash

# =========================================================
# Graylog Ingestion Check
# =========================================================
# Description:
# Generalized workflow for validating
# centralized logging ingestion.
#
# Intended for:
# - syslog validation
# - logging visibility
# - monitoring operations
# - infrastructure observability
#
# NOTE:
# Sanitized educational example.
# =========================================================

GRAYLOG_SERVER="$1"

if [ -z "$GRAYLOG_SERVER" ]; then
  echo "Usage: $0 <graylog_server_ip>"
  exit 1
fi

echo "======================================"
echo " Graylog Ingestion Check"
echo "======================================"

echo ""
echo "[+] Connectivity Validation"
ping -c 3 "$GRAYLOG_SERVER"

echo ""
echo "[+] Syslog Port Validation"
timeout 5 bash -c "cat < /dev/null > /dev/tcp/$GRAYLOG_SERVER/9000" \
  && echo "Graylog web interface reachable" \
  || echo "Graylog web interface unreachable"

echo ""
echo "[+] Syslog Listener Validation"
echo "Validate configured syslog listeners:"
echo "- UDP 514"
echo "- TCP 514"
echo "- GELF inputs"

echo ""
echo "[+] Operational Validation"
echo "Review:"
echo "- ingestion throughput"
echo "- parsing pipelines"
echo "- failed processing"
echo "- storage utilization"

echo ""
echo "Graylog validation workflow completed."
