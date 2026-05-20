#!/usr/bin/env python3

"""
Zabbix Host Audit

Generic sanitized example for auditing Zabbix hosts via API.

Example usage:
    python3 zabbix-host-audit.py --url https://zabbix.example.com/api_jsonrpc.php --token TOKEN
"""

import argparse
import json
import requests
import sys


def zabbix_api_request(url: str, token: str, method: str, params: dict) -> dict:
    payload = {
        "jsonrpc": "2.0",
        "method": method,
        "params": params,
        "auth": token,
        "id": 1,
    }

    response = requests.post(url, json=payload, timeout=15)
    response.raise_for_status()

    data = response.json()

    if "error" in data:
        raise RuntimeError(data["error"])

    return data.get("result", [])


def audit_hosts(url: str, token: str) -> None:
    hosts = zabbix_api_request(
        url,
        token,
        "host.get",
        {
            "output": ["hostid", "host", "name", "status"],
            "selectInterfaces": ["ip", "dns", "type", "main"],
            "selectGroups": ["name"],
        },
    )

    print("=" * 80)
    print("ZABBIX HOST AUDIT")
    print("=" * 80)

    for host in hosts:
        status = "Enabled" if host.get("status") == "0" else "Disabled"
        groups = ", ".join(group["name"] for group in host.get("groups", []))

        print(f"\nHost ID : {host.get('hostid')}")
        print(f"Host    : {host.get('host')}")
        print(f"Name    : {host.get('name')}")
        print(f"Status  : {status}")
        print(f"Groups  : {groups or 'N/A'}")

        for interface in host.get("interfaces", []):
            print(f"IP/DNS   : {interface.get('ip') or interface.get('dns')}")

        print("-" * 80)


def main() -> None:
    parser = argparse.ArgumentParser(description="Audit Zabbix hosts through the Zabbix API.")
    parser.add_argument("--url", required=True, help="Zabbix API URL.")
    parser.add_argument("--token", required=True, help="Zabbix API token.")

    args = parser.parse_args()

    try:
        audit_hosts(args.url, args.token)
    except Exception as error:
        print(f"[ERROR] {error}")
        sys.exit(1)


if __name__ == "__main__":
    main()
