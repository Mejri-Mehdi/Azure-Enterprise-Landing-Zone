# ADR-003: Policy as Code with Bicep

## Status
Accepted

## Context
Need to enforce governance (tags, locations, security) across 4 management groups.

## Decision
Define all policies in Bicep, deploy via GitHub Actions, assign at mg-root.

## Consequences
- **Positive:** Version-controlled governance, reproducible across environments
- **Positive:** CI/CD pipeline tests policies before deployment
- **Negative:** Requires Bicep knowledge from governance team
- **Negative:** Policy changes follow full deployment lifecycle (may delay urgent compliance fixes)

## Rationale
Treating policy as code ensures that governance rules are auditable, testable, and consistent. Bicep’s integration with ARM and management groups makes it the natural choice.