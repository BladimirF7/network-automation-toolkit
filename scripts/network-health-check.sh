#!/bin/bash

# Network Health Check
# Basic operational network validation script.

echo "======================================"
echo " Network Health Check"
echo "======================================"

echo ""
echo "[+] Hostname"
hostname

echo ""
echo "[+] Uptime"
uptime

echo ""
echo "[+] IP Addresses"
ip -br addr

echo ""
echo "[+] Default Route"
ip route | grep default || echo "No default route found"

echo ""
echo "[+] DNS Resolution Test"
for domain in google.com github.com cloudflare.com; do
  echo -n "$domain: "
  getent hosts "$domain" >/dev/null && echo "OK" || echo "FAILED"
done

echo ""
echo "[+] Gateway Ping Test"
GATEWAY=$(ip route | awk '/default/ {print $3; exit}')
if [ -n "$GATEWAY" ]; then
  ping -c 3 "$GATEWAY"
else
  echo "No gateway detected"
fi

echo ""
echo "[+] Internet Connectivity Test"
ping -c 3 1.1.1.1

echo ""
echo "[+] Listening Ports"
ss -tulpn

echo ""
echo "Health check completed."
