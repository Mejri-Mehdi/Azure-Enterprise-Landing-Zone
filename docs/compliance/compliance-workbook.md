# Azure Workbook: NexGen Compliance Dashboard

## Purpose
Provide a single‑pane‑of‑glass view of Azure Policy compliance across all subscriptions and management groups in the NexGen foundation.

## Queries Included
- **Overall Compliance State (pie chart):** Distribution of all policy evaluation results (Compliant, Non‑Compliant, etc.).
- **Top Non‑Compliant Resources (table):** The first 50 resources that are currently out of compliance.
- **Compliance Rate by Policy (table):** Percentage compliance for each policy, sorted from lowest to highest compliance rate.

## Deployment
The workbook is defined in `docs/compliance/compliance-workbook.json`.  
Import it via Azure Monitor → Workbooks → Advanced Editor.

## How to Use
- Pin the dashboard to your Azure Dashboard for real‑time visibility.
- Use the table of non‑compliant resources to drive remediation tasks.
- Monitor compliance rates after deploying new policies to ensure they are effective.

## Screenshot
![Compliance Dashboard](compliance-dashboard-screenshot.png)