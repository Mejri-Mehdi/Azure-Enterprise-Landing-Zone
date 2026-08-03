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