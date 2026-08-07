# 🏢 Azure Enterprise Landing Zone — NexGen Cloud Foundation

**Production-Grade Azure Foundation — Built from Scratch**  
*A complete, automated, governance-first cloud operating model for a fictional mid-size company (NexGen Tech)*

---

## 📖 Project Vision

I stepped into the role of **Cloud Platform Engineer** for NexGen Tech — a company migrating to Azure with **zero cloud footprint**. My mission: design and build their entire Azure foundation — subscriptions, governance, networking, security, cost controls, and a self-service developer experience — entirely as code.

This repository is the result: a **real-world, deployable enterprise landing zone** that demonstrates not just how to use Azure, but how to design how an organization uses Azure at scale.

---

## 🗺️ Architecture at a Glance

![High-Level Architecture Overview](Architecture%20Overview.png)

*The full logical architecture: management groups, hub-spoke network, governance layer, and self-service platform.*

![Hub-and-Spoke Network Diagram](02-hub-and-spoke-network.png)

*Detailed network diagram: hub VNet with Bastion, Firewall, gateway; peered to Prod and Dev spokes; tiered NSGs, private endpoints, and forced tunneling.*

---

## 🧱 What I Built — Phase by Phase

Every phase was built and deployed with **Bicep**, validated via **GitHub Actions**, and documented with decision records and dashboards.

### 🛡️ Phase 1 — Governance Foundation
The control plane that everything else sits on.
- **Management Group Hierarchy**: `mg-nexgen-root` → `mg-prod`, `mg-nonprod`, `mg-sandbox`  
- **Custom RBAC Roles**: 5 roles (Platform Engineer, DevOps, Developer, Security Reader, Cost Manager) implementing least‑privilege.
- **Azure Policy as Code**: 7 custom policies (require CostCenter & Environment tags, allowed locations, deny public IP on VMs, storage no public blob, NSG no open RDP, Key Vault soft‑delete) bundled into a **NexGen Secure Baseline Initiative**.
- **Tagging Strategy**: Mandatory tags `CostCenter`, `Environment`, `Owner` — enforced by policy.
- **Budgets & Alerts**: $50 non‑prod / $100 prod monthly budgets with 50/80/100% email alerts.
- **CI/CD**: GitHub Actions pipeline to deploy governance on push.

### 🌐 Phase 2 — Network Architecture
Hub‑and‑spoke with zero‑trust networking.
- **Hub VNet** (`10.0.0.0/16`) with subnets: `AzureBastionSubnet`, `AzureFirewallSubnet`, `GatewaySubnet`, `snet-shared-svc`.
- **Azure Bastion** (Standard SKU) for secure VM access without public IPs.
- **Azure Firewall** with forced‑tunneling UDR (0.0.0.0/0 → firewall private IP) on the shared‑services subnet.
- **Spoke VNets**: `vnet-prod-eastus` (10.1.0.0/16, 3‑tier subnets: web, app, db) and `vnet-dev-eastus` (10.2.0.0/16, single subnet).
- **VNet Peering** with gateway transit — hub connected to spokes, but spokes cannot talk directly.
- **Tiered NSGs**: Web allows HTTP/HTTPS + SSH from Bastion only; App allows port 8080 from Web subnet only; DB allows 1433 from App subnet only. Explicit Deny All at priority 4096.
- **Private DNS Zones** for blob, keyvault, and SQL — linked to all VNets, ready for Private Endpoints.

### 🔒 Phase 3 — Security Baseline & Shared Services
Making the foundation fortress‑grade and operationally ready.
- **Log Analytics Workspace** (PerGB2018, 30‑day retention, resource‑based access control).
- **Recovery Services Vault** with daily backup policy (30‑day retention, instant restore, public network access disabled).
- **Azure Container Registry** (Standard SKU, admin disabled, Entra ID auth only).
- **Activity Log Alert**: immediate email on resource group deletion via Action Group.
- **Shared Services Orchestrator** (`main.bicep`): one command deploys all the above to `rg-shared-services-hub`.

### 🧑‍💻 Phase 4 — Self‑Service Developer Platform
Empowering developers to get environments in minutes, not days.
- **Reusable Bicep Modules** (library):  
  - Linux VM (no public IP, auto‑tags)  
  - App Service (VNet‑integrated, HTTPS enforced, FTPS disabled)  
  - Storage Account (public access denied, service endpoint, auto‑container)  
  - SQL Server (public access disabled, Private Endpoint + DNS auto‑registration)
- **Environment Orchestrator** (`dev-environment.bicep`): deploys a complete dev environment (RG + App Service + Storage + SQL) using the modules, with globally unique names via `uniqueString()`.
- **GitHub Actions Workflow** (`provision-environment.yml`): manual trigger with environment choice, Bicep build + what‑if validation, and production approval gates.

### 📊 Phase 5 — Polish & Documentation
Turning a working infrastructure into a portfolio piece.
- **Compliance Dashboard** (Azure Workbook): real‑time policy compliance pie chart, top non‑compliant resources, compliance rate by policy.
- **Cost Dashboard** (Azure Workbook): cost by environment, top resource groups by spend.
- **Architecture Decision Records (ADRs)** (5 docs): Bicep vs Terraform, Hub‑and‑Spoke topology, Policy as Code, Private Endpoint strategy, Self‑Service platform.
- **Network Architecture Diagram** (draw.io, color‑coded) + traffic flow documentation (inbound, east‑west, outbound).
- **Operational Scripts**: cleanup script with confirmation prompt, policy compliance check via CLI.
- **Master README** and **CHANGELOG** with full release history.

---

## 🏛️ Enterprise Architecture Highlights

### Governance at Scale
- **4 Management Groups** with inherited policy enforcement
- **7 custom policies** bundled into the **NexGen Secure Baseline Initiative**
- **5 custom RBAC roles** implementing true least-privilege
- **Automatic tagging** on every resource (CostCenter, Environment, Owner)

### Zero-Trust Networking
- **Hub-and-Spoke topology** with Azure Firewall as central egress
- **No public IPs on workloads** — Bastion-only access
- **Tiered NSGs**: Web allows 80/443, App allows 8080 from Web only, DB allows 1433 from App only
- **Private Endpoints** for SQL; service endpoint for Storage; VNet integration for App Service
- **Private DNS Zones** resolving public FQDNs to internal IPs

### Developer Experience
- **4 reusable Bicep modules** (VM, App Service, Storage, SQL)
- **Self-service environment provisioning** via GitHub Actions
- **Approval gates** for production deployments
- **Environment auto‑tagging** with budget alerts and optional auto‑shutdown

### Operational Excellence
- **Compliance Dashboard** (Azure Workbook) with real‑time policy status
- **Cost Dashboard** tracking spend by environment and resource group
- **Backup policies** with 30‑day retention and instant restore
- **Automated alerts** for resource group deletion and budget thresholds

![Mind Map of Key Components](./diagram1.svg)
*Interactive mind map of the entire foundation.*

![Project Journey & Skills Demonstrated][text](<diagram 2.html>)
*At a glance: how each phase maps to real‑world cloud architect skills.*

---

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

---

## 🎓 What This Proves

This is **not a tutorial repo**. This is a **cloud operating model** that demonstrates:

1. **Governance Architecture** — I can design how an entire organization uses Azure  
2. **Network Security** — I understand zero‑trust, segmentation, and traffic flow  
3. **Platform Engineering** — I can build self‑service infrastructure for developers  
4. **FinOps** — I implement cost controls and chargeback from day one  
5. **Operational Maturity** — I document decisions, validate compliance, and automate cleanup  

---

## 🚀 Quick Start

1. **Prerequisites**  
   - Azure CLI, Bicep CLI, a GitHub repo with secrets `AZURE_CREDENTIALS` and `SQL_ADMIN_PASSWORD`  
2. **Deploy Governance**  
   ```bash
   az deployment tenant create --location eastus --template-file src/governance/management-groups.bicep
   az deployment mg create --management-group-id mg-nexgen-root --location eastus --template-file src/policies/initiatives/nexgen-secure-baseline/main.bicep
   ```

3. **Deploy Hub & Spokes**

See the `src/networking/` folder.

4. **Deploy Shared Services**

Run:

```bash
az deployment sub create \
  --location eastus \
  --template-file src/shared-services/main.bicep \
  --parameters emailAddress='you@example.com'
```

5. **Provision a Dev Environment**

Trigger the `provision-environment.yml` GitHub Actions workflow with:

```yaml
environment: dev
```

6. **Explore Dashboards**

Import workbooks from:

```
docs/compliance/
```

Full instructions are available inside each phase folder and the project documentation.

---

# 📁 Repository Structure

```text
├── src/
│   ├── governance/            # Management groups, RBAC, budgets
│   ├── policies/              # Policy definitions & initiatives
│   ├── networking/            # Hub, spokes, peering, DNS, NSGs
│   ├── security/              # Key Vault, Private Endpoints (coming soon)
│   ├── shared-services/       # Log Analytics, RSV, ACR, alerts
│   ├── modules/               # Reusable Bicep modules (compute, storage, database)
│   └── environments/          # Environment orchestrators (dev, test, prod)
│
├── .github/workflows/         # CI/CD pipelines
│
├── docs/
│   ├── architecture/          # Diagrams, traffic flows, ADRs
│   ├── compliance/            # Dashboards, cost guides
│   └── decisions/              # Architecture Decision Records
│
├── scripts/                   # Utility & validation scripts
│
├── CHANGELOG.md
└── README.md
```

---

# 💸 Cost Warning

⚠️ **Important Azure Cost Considerations**

- **Azure Firewall** costs approximately **$1.25/hour**.
- Deploy, test, capture screenshots, then destroy resources using:

```bash
scripts/utility/cleanup-environment.sh
```

- Configure a **budget alert** before deploying any resources.
- Always delete test resource groups immediately after validation.

---

# 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Infrastructure as Code (IaC) | Bicep (primary), ARM JSON |
| CI/CD | GitHub Actions |
| Governance | Management Groups, Azure Policy, RBAC |
| Networking | VNet, NSG, Azure Firewall, Bastion, Private Link |
| Security | Key Vault, Defender for Cloud (planned), Private Endpoints |
| Monitoring | Log Analytics, Azure Monitor, Workbooks |
| Scripting | Azure CLI, PowerShell, Bash |

---

# 📄 Documentation

| Documentation | Location |
|---|---|
| Architecture Decision Records | `docs/decisions/` |
| Network Diagram & Traffic Flows | `docs/architecture/` |
| Compliance Dashboard | `docs/compliance/compliance-workbook.json` |
| Cost Allocation Guide | `docs/compliance/cost-allocation-guide.md` |

---

# 📅 Changelog

See the full release history:

[CHANGELOG.md](https://changelog.md/)

---

# 👤 Author

**Mejri Mehdi**

---

# 📝 License

MIT License — Use this as your own portfolio piece.

Credit appreciated but not required.

---

> Built with purpose.  
> Every decision documented.  
> Every resource coded.  
> This is how enterprises move to the cloud.
