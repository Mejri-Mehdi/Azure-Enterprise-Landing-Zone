# ADR-004: Private Endpoints for All PaaS

## Status
Accepted

## Context
PaaS services (Storage, SQL, Key Vault, ACR) have public endpoints by default, exposing them to internet threats.

## Decision
Mandatory Private Endpoints for all PaaS in production. Public access disabled.

## Consequences
- **Positive:** Zero public exposure of data plane
- **Positive:** Traffic stays on Azure backbone, improving security posture
- **Negative:** DNS complexity (requires privatelink zones and careful name resolution)
- **Negative:** Slightly higher cost (~$0.01/hour per endpoint)

## Rationale
Private Endpoints align with the Zero Trust security model and Azure’s Well-Architected Framework. The additional cost and DNS setup are acceptable trade-offs for eliminating data exfiltration risks.