#!/bin/bash

# Zabbix Agent Host Validation
# Validates basic Zabbix agent connectivity and system readiness.

ZABBIX_SERVER="$1"

if [ -z "$ZABBIX_SERVER" ]; then
  echo "Usage: $0 <zabbix_server_ip>"
  exit 1
fi

echo "======================================"
echo " Zabbix Host Validation"
echo "======================================"

echo ""
echo "[+] Hostname"
hostname

echo ""
echo "[+] Checking Zabbix Agent Service"
systemctl status zabbix-agent --no-pager || systemctl status zabbix-agent2 --no-pager

echo ""
echo "[+] Checking Listening Ports"
ss -tulpn | grep -E '10050|10051' || echo "No Zabbix ports detected locally"

echo ""
echo "[+] Testing Connectivity to Zabbix Server"
ping -c 3 "$ZABBIX_SERVER"

echo ""
echo "[+] Testing TCP Port 10051"
timeout 5 bash -c "cat < /dev/null > /dev/tcp/$ZABBIX_SERVER/10051" \
  && echo "Connection to Zabbix server port 10051 successful" \
  || echo "Connection to Zabbix server port 10051 failed"

echo ""
echo "Zabbix validation completed."
