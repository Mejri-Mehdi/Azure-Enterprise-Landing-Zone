param sqlServerName string
param location string = resourceGroup().location
param environment string = 'dev'
param adminUsername string = 'sqladmin'

@secure()
param adminPassword string

param subnetId string                                   // subnet for the Private Endpoint
param privateDnsZoneId string = '/subscriptions/${subscription().subscriptionId}/resourceGroups/rg-networking-hub/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net'

// ── SQL Server ──────────────────────────────────────
resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: sqlServerName
  location: location
  tags: {
    Environment: environment
    CostCenter: 'shared'
    Owner: 'platform-team'
  }
  properties: {
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
    version: '12.0'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Disabled'
  }
}

// ── SQL Database ────────────────────────────────────
resource sqlDb 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: 'db-${environment}'
  location: location
  sku: { name: 'Basic', tier: 'Basic' }
  properties: {}
}

// ── Private Endpoint ────────────────────────────────
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = {
  name: 'pe-${sqlServerName}'
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'pe-conn-${sqlServerName}'
        properties: {
          privateLinkServiceId: sqlServer.id
          groupIds: ['sqlServer']
        }
      }
    ]
  }
}

// ── Private DNS Zone Group (auto‑registers A record) ─
resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-05-01' = {
  parent: privateEndpoint
  name: 'dns-group-sql'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config-sql'
        properties: {
          privateDnsZoneId: privateDnsZoneId
        }
      }
    ]
  }
}

// ── Outputs ─────────────────────────────────────────
output sqlServerId string = sqlServer.id
output sqlDbName string = sqlDb.name
output privateEndpointName string = privateEndpoint.name
output privateEndpointPrivateIp string = privateEndpoint.properties.networkInterfaces[0].properties.privateIPAddress
