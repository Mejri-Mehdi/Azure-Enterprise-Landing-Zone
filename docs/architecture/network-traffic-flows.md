# Network Traffic Flows

## Inbound: Internet → App
1. User hits App Gateway Public IP (future) or Firewall
2. Firewall inspects, allows 443
3. Traffic enters Hub VNet
4. Peering routes to Spoke-Prod snet-web
5. NSG allows 80/443 from Internet

## East-West: Prod → Hub Shared Services
1. VM in snet-web needs Key Vault secret
2. Route table sends traffic to Hub via peering
3. Private Endpoint resolves to 10.0.4.x
4. Key Vault receives request on private IP

## Outbound: VM → Internet
1. VM in snet-web sends request to 8.8.8.8
2. UDR on subnet: 0.0.0.0/0 → Firewall (10.0.2.x)
3. Firewall NATs to its public IP
4. Response returns same path

## Topology

---
![alt text](02-hub-and-spoke-network.png)
---