targetScope = 'subscription'

param location string = 'eastus'
param emailAddress string

// ── Resource Groups ──────────────────────────────────
resource rgShared 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-shared-services-hub'
  location: location
}

// Note: rg-networking-hub already exists from Phase 2, but we can
// redeclare it here to ensure it's present when needed.
resource rgNetHub 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-networking-hub'
  location: location
}

// ── Shared Services Modules ──────────────────────────

// 1. Log Analytics Workspace
module logAnalytics 'monitoring/log-analytics.bicep' = {
  name: 'deploy-law'
  scope: rgShared
  params: { location: location }
}

// 2. Recovery Services Vault + Backup Policy
module backup 'backup/recovery-services.bicep' = {
  name: 'deploy-rsv'
  scope: rgShared
  params: { location: location }
}

// 3. Container Registry
module acr 'container-registry/acr.bicep' = {
  name: 'deploy-acr'
  scope: rgShared
  params: { location: location }
}

// 4. Action Group + Activity Log Alert
module alerts 'monitoring/alerts.bicep' = {
  name: 'deploy-alerts'
  scope: rgShared
  params: {
    location: location
    emailAddress: emailAddress
  }
}

// ── Outputs (optional but useful) ────────────────────
output logAnalyticsWorkspaceId string = logAnalytics.outputs.lawId
output rsvId string = backup.outputs.rsvId
output acrLoginServer string = acr.outputs.acrLoginServer
output actionGroupId string = alerts.outputs.actionGroupId
