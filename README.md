 

![alt text](<Architecture Overview.png>)
---

![alt text](02-hub-and-spoke-network.png)
---


## 🏛️ Enterprise Architecture Highlights

### Governance at Scale
- **4 Management Groups** with inherited policy enforcement
- **7 policies** bundled into the **NexGen Secure Baseline Initiative**
- **5 custom RBAC roles** implementing true least-privilege
- **Automatic tagging** on every resource (CostCenter, Environment, Owner)

### Zero-Trust Networking
- **Hub-and-Spoke topology** with Azure Firewall as central egress
- **No public IPs on workloads** — Bastion-only access
- **Tiered NSGs**: Web allows 80/443, App allows 8080 from Web only, DB allows 1433 from App only
- **Private Endpoints** for Storage, SQL, Key Vault, ACR
- **Private DNS Zones** resolving public FQDNs to internal IPs

### Developer Experience
- **4 reusable Bicep modules** (VM, App Service, Storage, SQL)
- **Self-service environment provisioning** via GitHub Actions
- **Approval gates** for production deployments
- **Environment auto-tagging** with budget alerts

### Operational Excellence
- **Compliance Dashboard** (Azure Workbook) with real-time policy status
- **Cost Dashboard** tracking spend by environment and team
- **Backup policies** with 30-day retention and instant restore
- **Automated alerts** for resource group deletion and budget thresholds

![alt text](<markmap (2).svg>)

## 📊 Live Metrics

| Metric | Value |
|--------|-------|
| Management Groups | 4 |
| Custom Policies | 7 |
| Policy Initiatives | 1 |
| Custom RBAC Roles | 5 |
| VNets | 3 (1 hub + 2 spokes) |
| Subnets | 8 |
| NSGs | 5 |
| Private Endpoints | 4 |
| Reusable Bicep Modules | 4 |
| CI/CD Pipelines | 2 |

## 🎓 What This Proves

This is not a tutorial repo. This is a **cloud operating model** that demonstrates:

1. **Governance Architecture** — I can design how an entire organization uses Azure
2. **Network Security** — I understand zero-trust, segmentation, and traffic flow
3. **Platform Engineering** — I can build self-service infrastructure for developers
4. **FinOps** — I implement cost controls and chargeback from day one
5. **Operational Maturity** — I document decisions, validate compliance, and automate cleanup


![alt text](<markmap (3).svg>)