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
![alt text](<Screenshot 2026-08-04 175203.png>)
---
![alt text](<Screenshot 2026-08-04 175249.png>)
---
![alt text](<Screenshot 2026-08-04 175307.png>)
---
![alt text](<Screenshot 2026-08-04 175809.png>)
---
![alt text](<Screenshot 2026-08-04 175816.png>)
---

### Azure Firewall + Forced Tunneling

- **Firewall:** `fw-hub` (Standard SKU) in `AzureFirewallSubnet`.
- **UDR:** Route table `rt-hub-shared-svc` forces all internet‑bound traffic (0.0.0.0/0) to the firewall’s private IP.
- **Test Result:** VM in `snet-shared-svc` without a public IP shows egress IP = firewall public IP (screenshot attached).