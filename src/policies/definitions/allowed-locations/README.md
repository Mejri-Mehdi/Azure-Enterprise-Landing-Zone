# Policy: Allowed Azure Regions

## Purpose
Lock resource deployment to only pre‑approved Azure regions. This reduces data residency risk, controls cost by avoiding expensive regions, and enforces a consistent architecture for disaster recovery.

## Rule
- **Mode:** `Indexed` (applied to resources that support a location property).
- **Parameters:**
  - `allowedLocations` (Array) – list of permitted region names; default `['eastus', 'westus2']`.
- **Logic:**
  If the resource’s `location` is **not** in the allowed list → **Deny**.

## Important Note
The policy evaluates the **resource location**, not the resource group location. A resource group can be created in any region (it’s just a metadata container), but the resources inside it must be placed in `eastus` or `westus2`. This allows grouping of resources by region while maintaining strict location control.

## Why `eastus` and `westus2`?
- **Low latency & cost efficiency:** Both are standard US regions with broad service availability and competitive pricing.
- **Multi‑region DR strategy:** Spreading workloads across East US and West US 2 provides geographic redundancy for disaster recovery.
- **Simplicity:** Two regions are enough to demonstrate a production‑grade setup without overwhelming complexity.

## `strongType` Metadata
The parameter uses `"strongType": "location"`. This tells the Azure Portal to display a **location picker** when editing the policy assignment, making it easier for administrators to select valid regions from a dropdown instead of typing exact strings.

## Deployment
The policy definition is authored in **Bicep** and deployed at the management group scope (`mg-nexgen-root`).

```bash
az deployment mg create `
  --management-group-id mg-nexgen-root `
  --location eastus `
  --template-file src/policies/definitions/allowed-locations/main.bicep

az policy assignment create `
  --name "allowed-locations-assignment" `
  --policy "allowed-locations" `
  --scope "/providers/Microsoft.Management/managementGroups/mg-nexgen-root"
```

## Screenhsots

---
![alt text](<Screenshot 2026-08-03 061732.png>)
---
![alt text](<Screenshot 2026-08-03 061835.png>)
---
![alt text](<Screenshot 2026-08-03 061853.png>)
---