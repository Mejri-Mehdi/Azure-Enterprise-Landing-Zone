# Central Monitoring

- **Log Analytics Workspace:** `law-nexgen-hub-eastus` (PerGB2018, 30‑day retention).
- **Resource‑based access control:** Enabled (access to logs can be granted per resource, not just workspace‑wide).
- **Next:** Connect all spoke resources to send diagnostics here.

## Screenshots

---
![alt text](<Screenshot 2026-08-06 141519.png>)
---
![alt text](<Screenshot 2026-08-06 141548.png>)
---
![alt text](<Screenshot 2026-08-06 141617.png>)
--- 


# Monitoring & Alerting

## Action Group
- `ag-nexgen-critical` – sends email alerts to admin.

## Activity Log Alerts
- **Resource Group Deletion:** Triggers on any `resourceGroups/delete` operation in the subscription. Tested and verified.