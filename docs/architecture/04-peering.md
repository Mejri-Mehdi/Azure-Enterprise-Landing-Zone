# VNet Peering

- **Hub ↔ Prod** and **Hub ↔ Dev** fully peered.
- Gateway transit enabled on hub side (future VPN/ExpressRoute integration).
- Spokes use remote gateways (hub) but cannot communicate with each other directly – ensuring security isolation.
- Verified: VM‑to‑VM ping across peered networks.