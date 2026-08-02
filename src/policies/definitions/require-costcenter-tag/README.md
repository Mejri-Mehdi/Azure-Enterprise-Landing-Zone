# Policy: Require CostCenter Tag

## Purpose
Enforce that every resource in the mg-nexgen-root hierarchy has a `CostCenter` tag. This is the backbone of cost allocation and FinOps.

## Rule
- **Mode:** Indexed (tags are evaluated only on resources that support them)
- **Condition:** If the field `tags['CostCenter']` does **not** exist → **Deny** creation or update.

## Test Results
| Test | Tag Provided? | Outcome |
|------|---------------|---------|
| Storage Account | None | ❌ Blocked |
| Storage Account | CostCenter=CC123 | ✅ Allowed |

## Assignment
- **Scope:** `/providers/Microsoft.Management/managementGroups/mg-nexgen-root`
- Inherited by all child management groups and subscriptions.

## Next Steps
- Add more mandatory tags (Environment, Owner, Project).
- Combine into an Initiative (Azure Policy Set).
- Automate deployment via CI/CD pipeline.