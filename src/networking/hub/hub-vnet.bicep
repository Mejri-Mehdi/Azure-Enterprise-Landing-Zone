targetScope = 'resourceGroup'

param location string = 'eastus'

resource hubVnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: 'vnet-hub-eastus'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.0.1.0/26'
        }
      }
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: '10.0.2.0/26'
        }
      }
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '10.0.3.0/27'
        }
      }
      {
        name: 'snet-shared-svc'
        properties: {
          addressPrefix: '10.0.4.0/24'
        }
      }
    ]
  }
}

output hubVnetId string = hubVnet.id
output bastionSubnetId string = '${hubVnet.id}/subnets/AzureBastionSubnet'
output firewallSubnetId string = '${hubVnet.id}/subnets/AzureFirewallSubnet'
output sharedSvcSubnetId string = '${hubVnet.id}/subnets/snet-shared-svc'
