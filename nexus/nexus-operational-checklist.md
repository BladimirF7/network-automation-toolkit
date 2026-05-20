# Cisco Nexus Operational Checklist

---

# 🎯 Purpose

This document defines a generalized operational checklist for Cisco Nexus environments.

The objective is to:
- improve operational consistency
- validate infrastructure health
- standardize operational reviews
- improve monitoring visibility
- reduce operational risk

This checklist applies to:
- Cisco Nexus switches
- aggregation environments
- data center infrastructure
- enterprise network operations

---

# 📋 Operational Review Checklist

## System Health

Validate:
- CPU utilization
- memory utilization
- hardware alarms
- system uptime
- environmental health

Useful commands:
```bash
show system resources
show environment
```

---

## Interface Validation

Review:
- operational status
- interface errors
- bandwidth utilization
- interface descriptions

Useful commands:
```bash
show interface status
show interface counters errors
```

---

## VLAN & VRF Validation

Validate:
- VLAN consistency
- VRF assignments
- segmentation standards
- trunk consistency

Useful commands:
```bash
show vlan brief
show vrf
```

---

## Routing Validation

Review:
- BGP sessions
- OSPF neighbors
- static routes
- ECMP consistency

Useful commands:
```bash
show ip route
show bgp summary
show ip ospf neighbors
```

---

## Logging & Monitoring

Review:
- syslog forwarding
- SNMP status
- monitoring integrations
- alert visibility

Recommended integrations:
- Zabbix
- Graylog
- SIEM platforms

---

# 🔐 Security Validation

Validate:
- AAA configuration
- administrative access restrictions
- management ACLs
- SSH access
- logging visibility

---

# 🚫 Common Operational Issues

Common issues include:
- stale VLAN configurations
- inconsistent VRFs
- unmanaged interfaces
- disabled logging
- missing monitoring visibility
- routing instability
- undocumented changes

---

# ⚠️ Disclaimer

This document is intended for educational and operational reference purposes.

Operational requirements may vary depending on:
- infrastructure architecture
- operational maturity
- network scale
- compliance obligations
