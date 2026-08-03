# Policy: Require Soft Delete on Key Vaults

## Purpose
Prevent permanent loss of secrets, keys, and certificates by enforcing soft delete on all Azure Key Vaults. Soft delete allows recovery of vaults and their contents for a retention period (default 90 days) after deletion, which protects against accidental or ransomware-induced deletions.

## Rule
- **Mode:** `Indexed`
- **Target resource:** `Microsoft.KeyVault/vaults`
- **Condition:** If `enableSoftDelete` is missing or set to `false` → **Deny**.

## Why This Matters
- Prevents irreversible deletion of critical secrets and certificates.
- Aligns with the Azure Well-Architected Framework and security best practices.
- Required for compliance with many regulatory standards (e.g., SOC 2, PCI DSS).

## Test Results
| Test Case | Soft Delete Enabled? | Outcome |
|-----------|----------------------|---------|
| Create Key Vault with soft delete off | `false` | ❌ Blocked |
| Create Key Vault with soft delete on | `true` | ✅ Allowed |
| Update existing vault to disable soft delete | `false` (update) | ❌ Blocked (policy evaluates updates too) |

## Assignment
- **Scope:** `/providers/Microsoft.Management/managementGroups/mg-nexgen-root`
- Inherited by all child management groups and subscriptions.

## Next Steps
- Also enforce **purge protection** (immutable retention) via a complementary policy.
- Link to Private Endpoint and RBAC-only access for Key Vault in Phase 3.

## Screenshots

---
![alt text](<Screenshot 2026-08-03 165657.png>)
---
![alt text](<Screenshot 2026-08-03 165827.png>)
---
![alt text](<Screenshot 2026-08-03 165835.png>)
---