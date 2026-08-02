# Management Group Hierarchy

## Current State
- **Tenant Root Group** (`/providers/Microsoft.Management/managementGroups/{tenant-id}`)
  - **mg-nexgen-sandbox** – Sandbox environment for testing and experimentation.

## Naming Convention
- `mg-` prefix stands for “management group”.
- `nexgen` refers to the fictional company NexGen Tech.
- `sandbox` identifies the environment type.

## Next Steps
- Add `mg-prod` and `mg-nonprod` management groups.
- Apply Azure Policies at the management group level.
- Build the full hierarchy: `mg-root` → `mg-prod`, `mg-nonprod`, `mg-sandbox`. 