targetScope = 'resourceGroup'

param location string = 'eastus'
param keyVaultName string = 'kv-nexgen-hub-eastus'

// Reference existing Key Vault (we only need its ID and properties for PE)
resource kv 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
}

// Private Endpoint in the hub's shared-services subnet
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = {
  name: 'pe-${keyVaultName}'
  location: location
  properties: {
    subnet: {
      id: resourceId('rg-networking-hub', 'Microsoft.Network/virtualNetworks/subnets', 'vnet-hub-eastus', 'snet-shared-svc')
    }
    privateLinkServiceConnections: [
      {
        name: 'pe-conn-${keyVaultName}'
        properties: {
          privateLinkServiceId: kv.id
          groupIds: ['vault']
        }
      }
    ]
  }
}

// Link to the existing private DNS zone (from Day 21)
resource dnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-05-01' = {
  name: 'default'
  parent: privateEndpoint
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-vaultcore'
        properties: {
          privateDnsZoneId: resourceId('rg-networking-hub', 'Microsoft.Network/privateDnsZones', 'privatelink.vaultcore.azure.net')
        }
      }
    ]
  }
}
