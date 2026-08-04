targetScope = 'resourceGroup'

param hubVnetId string
param prodVnetId string
param devVnetId string

// Private DNS Zones for common PaaS services
resource dnsBlob 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.blob.core.windows.net'
  location: 'global'
}

resource dnsVault 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.vaultcore.azure.net'
  location: 'global'
}

resource dnsSql 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.database.windows.net'
  location: 'global'
}

// Array of VNets to link
var vnets = [
  { name: 'hub', id: hubVnetId }
  { name: 'prod', id: prodVnetId }
  { name: 'dev', id: devVnetId }
]

// Link each zone to all VNets
resource linkBlob 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = [for vnet in vnets: {
  name: 'link-blob-${vnet.name}'
  parent: dnsBlob
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: { id: vnet.id }
  }
}]

resource linkVault 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = [for vnet in vnets: {
  name: 'link-vault-${vnet.name}'
  parent: dnsVault
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: { id: vnet.id }
  }
}]

resource linkSql 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = [for vnet in vnets: {
  name: 'link-sql-${vnet.name}'
  parent: dnsSql
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: { id: vnet.id }
  }
}]
