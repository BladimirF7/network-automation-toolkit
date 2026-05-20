#!/usr/bin/env python3

"""
REST API Device Query

Generic example script for querying an infrastructure REST API endpoint.
This is a sanitized public-safe template.
"""

import argparse
import requests
import sys


def query_api(base_url: str, token: str, endpoint: str) -> None:
    url = f"{base_url.rstrip('/')}/{endpoint.lstrip('/')}"

    headers = {
        "Authorization": f"Bearer {token}",
        "Accept": "application/json",
    }

    try:
        response = requests.get(url, headers=headers, timeout=10)
        response.raise_for_status()
    except requests.exceptions.RequestException as error:
        print(f"[ERROR] API request failed: {error}")
        sys.exit(1)

    print(response.json())


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Query a generic infrastructure REST API endpoint."
    )

    parser.add_argument("--base-url", required=True, help="Base API URL")
    parser.add_argument("--token", required=True, help="API bearer token")
    parser.add_argument("--endpoint", required=True, help="API endpoint path")

    args = parser.parse_args()

    query_api(args.base_url, args.token, args.endpoint)


if __name__ == "__main__":
    main()
