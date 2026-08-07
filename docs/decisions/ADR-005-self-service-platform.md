# ADR-005: Self-Service Developer Platform

## Status
Accepted

## Context
Platform team was bottlenecked by manual environment provisioning. Developers waited days for dev/test resources.

## Decision
Reusable Bicep modules + GitHub Actions workflow + issue templates.

## Consequences
- **Positive:** Developers get environments in minutes, not days
- **Positive:** Standardized, compliant-by-default resources (tags, network, security)
- **Negative:** Requires module maintenance and versioning
- **Negative:** Developers must learn basic Bicep parameters or use issue templates

## Rationale
A self-service model empowers development teams while ensuring governance is baked in, not bolted on. The initial investment in module creation pays off rapidly by eliminating repetitive provisioning tasks.