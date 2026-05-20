#!/bin/bash

# WireGuard Peer Audit
# Requires: wg

echo "======================================"
echo " WireGuard Peer Audit"
echo "======================================"

if ! command -v wg >/dev/null 2>&1; then
  echo "WireGuard command 'wg' not found."
  exit 1
fi

echo ""
echo "[+] WireGuard Interfaces"
wg show interfaces

echo ""
echo "[+] Peer Summary"
wg show all

echo ""
echo "[+] Latest Handshakes"
wg show all latest-handshakes

echo ""
echo "[+] Transfer Statistics"
wg show all transfer

echo ""
echo "WireGuard audit completed."
