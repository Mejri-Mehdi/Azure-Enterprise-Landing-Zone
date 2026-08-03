# Policy: Deny Unrestricted RDP (3389) in NSG Rules

## Purpose
Prevent security rules that allow inbound RDP (port 3389) from **any source address**. This forces all remote desktop access to go through Azure Bastion or be restricted to specific trusted IP ranges.

## Rule Details
- **Mode:** `All` – required because NSG rules are sub-resources and do not support tags.
- **Condition:** All of the following must be true for a deny:
  1. Resource type is `Microsoft.Network/networkSecurityGroups/securityRules`.
  2. Destination port range equals `3389`.
  3. Source address prefix equals `*` (any).
  4. Access is `Allow`.
  5. Direction is `Inbound`.

## Why This Matters
- Removes a common misconfiguration that exposes VMs to brute-force attacks.
- Aligns with Azure Security Benchmark and CIS controls.
- Encourages the use of Bastion or just-in-time access for operational tasks.

## Test Results
| NSG Rule | Source | Destination Port | Outcome |
|----------|--------|------------------|---------|
| Allow RDP | `*` | 3389 | ❌ Denied |
| Allow RDP | `10.0.0.0/16` | 3389 | ✅ Allowed |
| Allow SSH | `*` | 22 | ✅ Allowed (different policy needed for SSH) |

## Assignment
- **Scope:** `/providers/Microsoft.Management/managementGroups/mg-nexgen-root`
- Inherited to all child management groups/subscriptions.

## Next Steps
- Create a similar policy for SSH (port 22).
- Combine with Bastion deployment in the Hub VNet.
- Use `audit` effect initially to find existing violations before enforcing `deny`.

## Screenshots

---
![alt text](<Screenshot 2026-08-03 165341.png>)
---
![alt text](<Screenshot 2026-08-03 165417.png>)
---
![alt text](<Screenshot 2026-08-03 165433.png>)
---