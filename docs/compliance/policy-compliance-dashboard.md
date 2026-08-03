# Policy Compliance Dashboard

## NexGen Secure Baseline Initiative
- **Scope:** mg-nexgen-root (inherits to all subscriptions)
- **Total Policies:** 7

| Policy | Effect | Protects Against |
|--------|--------|------------------|
| Require CostCenter tag | Deny | Untracked spend, lack of cost accountability |
| Require Environment tag | Deny | Misidentified environments, accidental production changes |
| Allowed locations | Deny | Data residency violations, uncontrolled region sprawl |
| Deny public IP on VMs | Deny | Direct internet exposure, brute-force attacks |
| Storage accounts: disable public blob access | Deny | Anonymous data leakage |
| NSG: no unrestricted RDP (3389) | Deny | Open management ports to the internet |
| Key Vault: soft delete required | Deny | Permanent deletion of secrets by ransomware/mistake |

## Compliance View

---
![alt text](<Screenshot 2026-08-03 170808.png>)
---

*All 7 policies are compliant in the sandbox subscription after testing. Production subscriptions will inherit the same protection.*

## Next Steps
- Add remediation tasks for existing non-compliant resources.
- Set up Azure Monitor alerts for policy non-compliance events.

## Screenshots

---
![alt text](<Screenshot 2026-08-03 170438.png>)
---
![alt text](<Screenshot 2026-08-03 170557.png>)
---
![alt text](<Screenshot 2026-08-03 170639.png>)
---