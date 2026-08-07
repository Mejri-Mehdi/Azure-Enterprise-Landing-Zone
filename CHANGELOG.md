# Changelog

## [1.0.0] - 2026-08-07
### Phase 1: Governance
- Management Group hierarchy (mg-root, mg-prod, mg-nonprod, mg-sandbox)
- 5 custom RBAC roles
- Budget alerts with action groups
- 7 Azure Policies + Secure Baseline Initiative

### Phase 2: Networking
- Hub VNet with Bastion, Firewall, Gateway, Shared Services subnets
- Spoke VNets (Prod 3-tier, Dev single)
- VNet peering with gateway transit
- Tiered NSGs (web/app/db defense in depth)
- Private DNS Zones

### Phase 3: Security & Shared Services
- Key Vault with CMK and Private Endpoint
- Log Analytics Workspace
- Recovery Services Vault with backup policy
- Container Registry
- Activity Log alerts

### Phase 4: Developer Platform
- 4 reusable Bicep modules
- Self-service environment orchestrator
- GitHub Actions CI/CD pipeline
- Developer onboarding docs

### Phase 5: Polish
- Compliance Dashboard (Azure Workbook)
- Cost Allocation Dashboard
- Network Architecture Diagram
- 5 Architecture Decision Records
- Cleanup and validation scripts

![alt text](<markmap (4).svg>)