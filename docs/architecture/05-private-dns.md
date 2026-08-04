# Private DNS Zones

- **Deployed zones:** `privatelink.blob.core.windows.net`, `privatelink.vaultcore.azure.net`, `privatelink.database.windows.net`
- **Linked VNets:** hub, prod, dev
- **Purpose:** When a Private Endpoint is created for a PaaS service, its FQDN will resolve to the private IP within the VNet, ensuring traffic stays on the Microsoft backbone and never traverses the public internet.
- **Registration enabled:** `false` (we are using auto‑registration by Private Endpoints, not manual records).