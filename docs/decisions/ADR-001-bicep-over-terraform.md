# ADR-001: Bicep over Terraform

## Status
Accepted

## Context
We needed Infrastructure as Code for an Azure-only environment. Terraform is multi-cloud; Bicep is Azure-native.

## Decision
Use Bicep as the primary IaC language.

## Consequences
- **Positive:** Native Azure integration, no state file management, free
- **Positive:** Day-zero support for new Azure features
- **Negative:** Azure-only (no multi-cloud portability)
- **Negative:** Smaller community and fewer third-party modules than Terraform

## Rationale
Since NexGen is 100% Azure, Bicep eliminates state file risks, integrates directly with ARM, and provides first-class support from Microsoft. The lack of multi-cloud capability is irrelevant to our roadmap.