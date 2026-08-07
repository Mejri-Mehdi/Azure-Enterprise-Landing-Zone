# Self‑Service Developer Environment

- **Orchestrator:** `src/environments/dev-environment.bicep`
- **Deploys:** Resource group, Storage Account (private), App Service (VNet‑integrated), SQL Server (Private Endpoint).
- **Names:** All globally unique via `uniqueString()`.
- **Tags:** Auto‑applied for environment, cost center, ownership, and auto‑shutdown.
- **Security:** No public access, Private Endpoint for SQL, storage firewall, HTTPS enforced.