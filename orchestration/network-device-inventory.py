#!/usr/bin/env python3

"""
Network Device Inventory

Generates a sanitized network device inventory report from a local JSON file.

Example usage:
    python3 network-device-inventory.py --input devices.json
"""

import argparse
import json
from pathlib import Path


def load_devices(file_path: str) -> list:
    path = Path(file_path)

    if not path.exists():
        raise FileNotFoundError(f"Input file not found: {file_path}")

    with path.open("r", encoding="utf-8") as file:
        data = json.load(file)

    if not isinstance(data, list):
        raise ValueError("Input JSON must be a list of devices.")

    return data


def print_inventory(devices: list) -> None:
    print("=" * 70)
    print("NETWORK DEVICE INVENTORY")
    print("=" * 70)

    for device in devices:
        print(f"\nDevice Name : {device.get('hostname', 'N/A')}")
        print(f"Vendor      : {device.get('vendor', 'N/A')}")
        print(f"Model       : {device.get('model', 'N/A')}")
        print(f"Role        : {device.get('role', 'N/A')}")
        print(f"Mgmt IP     : {device.get('management_ip', 'N/A')}")
        print(f"Site        : {device.get('site', 'N/A')}")
        print(f"Status      : {device.get('status', 'N/A')}")
        print("-" * 70)


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate a network device inventory report.")
    parser.add_argument("--input", required=True, help="Path to device inventory JSON file.")
    args = parser.parse_args()

    try:
        devices = load_devices(args.input)
        print_inventory(devices)
    except Exception as error:
        print(f"[ERROR] {error}")


if __name__ == "__main__":
    main()
