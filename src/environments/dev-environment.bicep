targetScope = 'subscription'

param location string = 'eastus'

@secure()
param adminPassword string

// ── Resource Group for the environment ──────────────
resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-nexgen-dev'
  location: location
  tags: {
    Environment: 'dev'
    CostCenter: 'engineering'
    Owner: 'platform-team'
    AutoShutdown: 'true'
  }
}

// ── Existing VNet details (from Phase 2) ────────────
var vnetName = 'vnet-dev-eastus'
var vnetRg = 'rg-networking-spoke-dev'
var subnetName = 'snet-dev-default'

// ── Module: Storage Account ─────────────────────────
module storage '../../modules/storage/storage-account/main.bicep' = {
  name: 'deploy-storage'
  scope: rg
  params: {
    storageAccountName: 'stnexgen${uniqueString(subscription().id, 'dev')}'   // unique per subscription
    location: location
    environment: 'dev'
    subnetId: resourceId(vnetRg, 'Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)
  }
}

// ── Module: App Service ─────────────────────────────
module appService '../../modules/compute/app-service/main.bicep' = {
  name: 'deploy-appservice'
  scope: rg
  params: {
    appName: 'app-nexgen-${uniqueString(subscription().id, 'dev')}'   // globally unique
    location: location
    environment: 'dev'
    subnetId: resourceId(vnetRg, 'Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)
    sku: 'B1'
  }
}

// ── Module: SQL Server + Database ───────────────────
module sql '../../modules/database/sql-server/main.bicep' = {
  name: 'deploy-sql'
  scope: rg
  params: {
    sqlServerName: 'sql-nexgen-${uniqueString(subscription().id, 'dev')}'   // globally unique
    location: location
    environment: 'dev'
    adminPassword: adminPassword
    subnetId: resourceId(vnetRg, 'Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)
  }
}

// ── Outputs ──────────────────────────────────────────
output resourceGroupName string = rg.name
output appUrl string = appService.outputs.appUrl
output storageAccountName string = storage.outputs.storageEndpoint
output sqlServerId string = sql.outputs.sqlServerId
