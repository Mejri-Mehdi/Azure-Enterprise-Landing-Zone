# ADR-002: Hub-and-Spoke Network Topology

## Status
Accepted

## Context
Need to connect multiple environments (prod, dev, shared services) with centralized security.

## Decision
Implement hub-and-spoke with Azure Firewall in the hub.

## Consequences
- **Positive:** Centralized egress/ingress control, shared services
- **Positive:** Spoke isolation (dev cannot talk to prod directly)
- **Negative:** Firewall is a single point of failure (mitigated by Availability Zones)
- **Negative:** Transit costs between spokes via hub

## Rationale
Hub-and-spoke is the Microsoft-recommended pattern for enterprise Azure networks. It provides a balance of security, manageability, and cost efficiency for a medium-sized organization like NexGen.