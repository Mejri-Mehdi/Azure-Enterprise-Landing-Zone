# Policy: Require Environment Tag

## Purpose
Ensure every resource deployed under the `mg-nexgen-root` hierarchy carries an `Environment` tag with a valid value (`Dev`, `Test`, `Prod`, or `Sandbox`). This policy drives environment identification, cost allocation, and automated lifecycle management.

## Rule
- **Mode:** `Indexed` (applied only to resources that support tags).
- **Parameters:**
  - `allowedEnvironments` (Array) – list of permitted values; default `['Dev', 'Test', 'Prod', 'Sandbox']`.
- **Logic:**
  1. If the field `tags['Environment']` **does not exist** → **Deny**.
  2. Or if `tags['Environment']` exists but its value is **not in** the allowed list → **Deny**.

## Deployment
The policy definition is authored in **Bicep** and deployed at the management group scope (`mg-nexgen-root`). This makes the definition available for assignment to the same scope or any child scope.

```bash
az deployment mg create \
  --management-group-id mg-nexgen-root \
  --location eastus \
  --template-file src/policies/definitions/require-environment-tag/main.bicep

az policy assignment create \
  --name "require-environment-tag-assignment" \
  --policy "require-environment-tag" \
  --scope "/providers/Microsoft.Management/managementGroups/mg-nexgen-root"
```

## Screenshots

---
![alt text](<Screenshot 2026-08-03 055502.png>)
---
![alt text](<Screenshot 2026-08-03 055944.png>)
---