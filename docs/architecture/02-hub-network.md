# Hub Network – Azure Bastion

## Deployment
- **Bastion Host:** `bastion-hub` (Standard SKU) deployed in `AzureBastionSubnet` (10.0.1.0/26) within `vnet-hub-eastus`.
- **Public IP:** `pip-bastion-hub` (static, required for Bastion).

## Secure Access
Bastion enables browser‑based RDP and SSH to VMs that have **no public IP**. All traffic traverses the Microsoft backbone, and no NSG rules need to open 3389/22 to the internet.

## Test Results
- Created VM `testvm-bastion` in `snet-shared-svc` without any public IP.
- Connected successfully via Portal → Bastion using RDP.
- Screenshot: `bastion-test-success.png`

## Screenshots

---
![alt text](<Screenshot 2026-08-04 174450.png>)
---