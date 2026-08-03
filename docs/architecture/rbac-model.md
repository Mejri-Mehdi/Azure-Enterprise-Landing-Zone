# Custom RBAC Model for NexGen Tech

This document defines the five custom Azure roles that form the foundation of our identity and access management strategy.

---

## Role Definitions

### 1. NexGen Platform Engineer
- **Permission level:** Full resource management (equivalent to Contributor).
- **Restrictions:** Cannot create/delete role assignments (`Microsoft.Authorization/*/Write`, `*/Delete`, `elevateAccess/Action`).
- **Why:** Platform Engineers need to build and maintain all infrastructure, but role assignment should be a separate privileged operation (managed by PIM or a separate dedicated account).

### 2. NexGen DevOps Engineer
- **Allowed:** Full control over `Microsoft.Compute`, `Microsoft.Network`, `Microsoft.Storage`, `Microsoft.Insights`, `Microsoft.RecoveryServices`, and resource group + deployment operations.
- **Blocked:** Any identity or security operations (`Microsoft.Authorization/*`, `Microsoft.AzureActiveDirectory/*`, `Microsoft.ManagedIdentity/*`, `Microsoft.KeyVault/*`).
- **Why:** DevOps Engineers focus on infrastructure and application delivery; they do not need to manage identities or secrets directly. This separation reduces the blast radius of a compromised CI/CD pipeline.

### 3. NexGen Developer
- **Allowed:** `*/read` across the entire subscription. Selected actions to deploy code to existing compute targets: publish to Web Apps, restart VMs, push/pull container images, and list storage account keys.
- **Blocked:** All delete operations (`*/delete`), creation of new resources via templates (`Microsoft.Resources/deployments/write`).
- **Why:** Developers need visibility and the ability to deploy applications, but should not be able to create or destroy infrastructure. This encourages a self‑service model while maintaining guardrails.

### 4. NexGen Security Reader
- **Allowed:** `*/read` only. No data actions.
- **Why:** Security teams need read‑only access to every resource, Security Center recommendations, and policy compliance states without any possibility of modification.

### 5. NexGen Cost Manager
- **Allowed:** `*/read` plus full access to `Microsoft.Consumption`, `Microsoft.CostManagement`, and billing read operations.
- **Why:** Finance and operations teams can monitor spending and manage budgets without touching infrastructure.

---

## Design Principles
- **Least privilege:** Every role starts with zero permissions; only the minimum required actions are granted.
- **Separation of duties:** No single role can manage both infrastructure and identity/security.
- **Automation ready:** Roles are defined in Bicep, deployed via CI/CD, and scoped at management group level for inheritance.

## Screenshots

---
![alt text](<Screenshot 2026-08-02 160534.png>)
---
![alt text](<Screenshot 2026-08-02 160917.png>)
---
![alt text](<Screenshot 2026-08-02 160932.png>)
---