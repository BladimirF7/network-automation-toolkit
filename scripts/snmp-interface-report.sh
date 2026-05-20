#!/bin/bash

# SNMP Interface Report
# Requires: snmpwalk

DEVICE="$1"
COMMUNITY="$2"

if [ -z "$DEVICE" ] || [ -z "$COMMUNITY" ]; then
  echo "Usage: $0 <device_ip> <snmp_community>"
  exit 1
fi

echo "======================================"
echo " SNMP Interface Report"
echo " Device: $DEVICE"
echo "======================================"

echo ""
echo "[+] Interface Descriptions"
snmpwalk -v2c -c "$COMMUNITY" "$DEVICE" IF-MIB::ifDescr

echo ""
echo "[+] Interface Operational Status"
snmpwalk -v2c -c "$COMMUNITY" "$DEVICE" IF-MIB::ifOperStatus

echo ""
echo "[+] Interface Inbound Octets"
snmpwalk -v2c -c "$COMMUNITY" "$DEVICE" IF-MIB::ifInOctets

echo ""
echo "[+] Interface Outbound Octets"
snmpwalk -v2c -c "$COMMUNITY" "$DEVICE" IF-MIB::ifOutOctets

echo ""
echo "SNMP report completed."
