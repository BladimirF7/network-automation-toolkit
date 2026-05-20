#!/usr/bin/env python3

"""
Telemetry API Collector

Generic sanitized example for collecting telemetry from a REST API endpoint.

Example usage:
    python3 telemetry-api-collector.py --base-url https://api.example.com --endpoint /devices --token TOKEN
"""

import argparse
import json
import sys
import requests


def collect_telemetry(base_url: str, endpoint: str, token: str) -> dict:
    url = f"{base_url.rstrip('/')}/{endpoint.lstrip('/')}"

    headers = {
        "Authorization": f"Bearer {token}",
        "Accept": "application/json",
    }

    response = requests.get(url, headers=headers, timeout=15)
    response.raise_for_status()

    return response.json()


def main() -> None:
    parser = argparse.ArgumentParser(description="Collect telemetry from a REST API endpoint.")
    parser.add_argument("--base-url", required=True, help="Base API URL.")
    parser.add_argument("--endpoint", required=True, help="API endpoint path.")
    parser.add_argument("--token", required=True, help="Bearer token.")
    parser.add_argument("--output", default="telemetry-output.json", help="Output JSON file.")

    args = parser.parse_args()

    try:
        telemetry = collect_telemetry(args.base_url, args.endpoint, args.token)

        with open(args.output, "w", encoding="utf-8") as file:
            json.dump(telemetry, file, indent=2)

        print(f"[OK] Telemetry saved to {args.output}")

    except requests.exceptions.RequestException as error:
        print(f"[ERROR] API request failed: {error}")
        sys.exit(1)

    except Exception as error:
        print(f"[ERROR] {error}")
        sys.exit(1)


if __name__ == "__main__":
    main()
