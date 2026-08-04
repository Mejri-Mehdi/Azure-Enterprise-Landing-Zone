targetScope = 'resourceGroup'

param location string = 'eastus'
param spokeName string          // 'prod' or 'dev'
param addressPrefix string      // '10.1.0.0/16' or '10.2.0.0/16'

var vnetName = 'vnet-${spokeName}-eastus'

resource spokeVnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [addressPrefix]
    }
    subnets: spokeName == 'prod' ? [
      {
        name: 'snet-web'
        properties: { addressPrefix: cidrSubnet(addressPrefix, 8, 0) }   // 10.1.0.0/24
      }
      {
        name: 'snet-app'
        properties: { addressPrefix: cidrSubnet(addressPrefix, 8, 1) }   // 10.1.1.0/24
      }
      {
        name: 'snet-db'
        properties: { addressPrefix: cidrSubnet(addressPrefix, 8, 2) }   // 10.1.2.0/24
      }
    ] : [
      {
        name: 'snet-dev-default'
        properties: { addressPrefix: cidrSubnet(addressPrefix, 8, 0) }   // 10.2.0.0/24
      }
    ]
  }
}

output vnetId string = spokeVnet.id
