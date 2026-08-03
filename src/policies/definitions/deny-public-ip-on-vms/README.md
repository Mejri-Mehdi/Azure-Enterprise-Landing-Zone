# Policy: Deny Public IP on VMs

## Purpose
Enforce a zero‑trust network model: no virtual machine may have a public IP address. All inbound access must go through Azure Bastion, keeping the VM’s NIC private.

## Rule
- **Mode:** `Indexed`
- **Target resource:** `Microsoft.Network/networkInterfaces`
- **Condition:** If any IP configuration on the NIC contains a `publicIpAddress.id` (i.e., a public IP is attached) → **Deny**.

## Why This Matters
- Eliminates direct attack surface on VMs.
- Centralizes access control through Bastion (Phase 2) or Azure Firewall.
- Prevents accidental exposure of development VMs.
- Required for compliance with security frameworks.

## Test Results
| Scenario | Public IP Attached? | Outcome |
|----------|---------------------|---------|
| Create NIC with public IP | Yes | ❌ Denied (policy violation) |
| Create NIC without public IP | No | ✅ Allowed |
| Create VM via portal with public IP | Yes | ❌ Blocked at NIC creation |

## Assignment
- **Scope:** `/providers/Microsoft.Management/managementGroups/mg-nexgen-root`
- Inherited by all subscriptions.

## Next Steps
- Combine with NSG hardening policies (e.g., deny SSH/RDP from Internet).
- Implement Bastion in the Hub VNet for secure VM connectivity.

## Screenshots

---
![alt text](<Screenshot 2026-08-03 062447.png>)
---
![alt text](<Screenshot 2026-08-03 062504.png>)
---