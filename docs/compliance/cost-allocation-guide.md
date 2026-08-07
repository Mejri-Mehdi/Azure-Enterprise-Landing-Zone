# Cost Allocation & Budget Strategy

This document explains the budget guardrails deployed for the NexGen Azure foundation.

---

## Budget Thresholds
- **Non‑Production environments:** $50/month  
- **Production environments:** $100/month

These values are deliberately low for a lab/learning environment, but they mirror the practice of setting a hard cost cap from day one. In a real enterprise, budgets would be significantly higher but still enforced at every subscription/environment level.

---

## Alert Thresholds
Each budget triggers email notifications at:
- **50 %** consumed – early awareness  
- **80 %** consumed – warning to review and adjust  
- **100 %** consumed – critical, action required

Multiple thresholds give teams time to react before costs exceed expectations. The action group `ag-budget-alerts` sends emails to the finance/ops contact.

---

## Current Implementation
- An **Action Group** (`ag-budget-alerts`) with email receivers.
- Two **Budgets** (`budget-nonprod` and `budget-prod`) deployed at subscription scope.
- All resources are tagged with `Environment` and `CostCenter` to enable future cost analysis.

---

## Future Improvements
- **Automated shutdown:** At 100 %, an Azure Function (triggered via budget action group) could automatically deallocate VMs or scale down resources.
- **Per‑team budgets:** Break down budgets by `CostCenter` tag to hold individual teams accountable.
- **Cost dashboards:** Build Azure Workbooks showing real‑time cost by project, environment, and resource type.
- **Anomaly alerts:** Enable Cost Management anomaly detection for unusual spend patterns.

## Screenshot

---
![alt text](<Screenshot 2026-08-02 163412.png>)
---

# Cost Allocation & FinOps Strategy

## Budget Strategy
- **Non‑Production (dev/test):** $50/month  
- **Production:** $100/month  

Budgets are enforced at subscription scope and trigger email alerts at 50%, 80%, and 100% thresholds.  
Action group `ag-budget-alerts` sends notifications to the platform team.

## Tag‑Driven Chargeback
All resources must carry the following mandatory tags (enforced by Azure Policy):
- **Environment:** `Dev`, `Test`, `Prod`, or `Sandbox`
- **CostCenter:** e.g., `CC123` (department/project code)
- **Owner:** team or individual responsible

These tags feed directly into:
- Azure Cost Analysis (Cost by Tag view)
- Our custom cost workbook (`cost-workbook.json`)
- Future showback/chargeback reports via Power BI or Azure Workbooks

## Cost Dashboard
Deployed via `docs/compliance/cost-workbook.json`.  
Displays:
- Cost by Environment (last 30 days)
- Top 10 Resource Groups by spend

If the native `usage` table is empty (because Cost Management export to Log Analytics isn’t set up), we use an **Azure Resource Graph fallback query**:

```kusto
resourcecontainers
| where type == 'microsoft.resources/subscriptions/resourcegroups'
| extend rgName = name, subscriptionName = tostring(tags.subscriptionName)
| join kind=inner (
    resourceinstances
    | where type in ('microsoft.compute/virtualmachines', 'microsoft.storage/storageaccounts', 'microsoft.web/sites', 'microsoft.sql/servers')
    | extend rg = tostring(resourceGroup), resourceType = type
) on $left.name == $right.rg
| summarize ResourceCount = count() by rgName, subscriptionName
```

This query helps identify resource concentration and potential cost drivers when native cost data isn’t available.

## Cost Cleanup Script

To prevent runaway costs in sandbox/dev environments, an auto‑shutdown script (PowerShell) can be deployed as an Azure Automation Runbook or GitHub Actions scheduled workflow:

``` powershell

# Example: Deallocate all VMs with tag AutoShutdown=true in a specific resource group
$rgName = "rg-nexgen-dev"
$vms = Get-AzVM -ResourceGroupName $rgName | Where-Object { $_.Tags['AutoShutdown'] -eq 'true' }
$vms | ForEach-Object { Stop-AzVM -ResourceGroupName $rgName -Name $_.Name -Force }
In a production setting, this would run nightly and target non‑production environments.
```

In a production setting, this would run nightly and target non‑production environments.
