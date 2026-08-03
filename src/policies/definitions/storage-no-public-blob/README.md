# Policy: Deny Public Blob Access on Storage Accounts

## Purpose
Eliminate the most common data leak vector in Azure—anonymous public read access to blob containers. This policy enforces that no storage account can be created or updated to allow public blob access.

## Rule
- **Mode:** `Indexed`
- **Target resource:** `Microsoft.Storage/storageAccounts`
- **Condition:** If the property `allowBlobPublicAccess` is set to `true` → **Deny**.

## Why This Matters
- Prevents accidental exposure of sensitive data stored in blobs.
- Aligns with Microsoft’s own security best practices and the Azure Security Benchmark.
- Forces all access to storage data to be authenticated and authorized via RBAC or SAS tokens with proper scoping.

## Test Results
| Test Case | `allowBlobPublicAccess` | Outcome |
|-----------|--------------------------|---------|
| Storage account with public access on | `true` | ❌ Blocked |
| Storage account with public access off | `false` | ✅ Allowed |

## Assignment
- **Scope:** `/providers/Microsoft.Management/managementGroups/mg-nexgen-root`
- Inherited by all child management groups and subscriptions.

## Next Steps
- Combine with other storage security policies (e.g., enforce HTTPS, minimum TLS version, delete lock on critical data).
- Enable `Azure Defender for Storage` via the security baseline phase.

## Screenshots

---
![alt text](<Screenshot 2026-08-03 062936.png>)
---
![alt text](<Screenshot 2026-08-03 063031.png>)
---