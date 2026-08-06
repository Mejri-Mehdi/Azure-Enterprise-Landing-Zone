# Shared Services Layer

## Overview
The shared‑services layer provides centralised operational and security capabilities used by all workloads in the Azure foundation.

## Components

| Service | Resource | Location | VNet / Subnet | Public Access |
|---------|----------|----------|---------------|---------------|
| Log Analytics Workspace | `law-nexgen-hub-eastus` | `rg-shared-services-hub` | None (global) | N/A |
| Recovery Services Vault | `rsv-nexgen-hub-eastus` | `rg-shared-services-hub` | None (later linked via Private Endpoint) | Disabled |
| Container Registry | `acrnexgenhub` | `rg-shared-services-hub` | None (public access enabled for testing; future Private Endpoint) | Enabled (to be locked down) |
| Action Group | `ag-nexgen-critical` | `rg-shared-services-hub` | Global | N/A |
| Activity Log Alert | `alert-rg-deletion` | `rg-shared-services-hub` | Global | N/A |

## Security Posture
- **Log Analytics**: Resource‑based access control enabled.
- **Recovery Services Vault**: Public network access disabled – ready for Private Endpoint.
- **Container Registry**: Admin user disabled; authenticated access only via Microsoft Entra ID.
- **Alerting**: Immediate email notification for critical administrative actions (e.g., resource group deletion).

## Deployment
All services are deployed from a single orchestrator Bicep file (`src/shared-services/main.bicep`) at the subscription scope, ensuring consistency and repeatability.