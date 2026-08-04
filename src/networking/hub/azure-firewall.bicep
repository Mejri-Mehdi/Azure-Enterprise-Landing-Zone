targetScope = 'resourceGroup'

param location string = 'eastus'

// Public IP for the firewall
resource fwPip 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: 'pip-firewall-hub'
  location: location
  sku: { name: 'Standard' }
  properties: { publicIPAllocationMethod: 'Static' }
}

// Azure Firewall
resource firewall 'Microsoft.Network/azureFirewalls@2023-05-01' = {
  name: 'fw-hub'
  location: location
  properties: {
    sku: { name: 'AZFW_VNet', tier: 'Standard' }
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', 'vnet-hub-eastus', 'AzureFirewallSubnet')
          }
          publicIPAddress: { id: fwPip.id }
        }
      }
    ]
  }
}

// Outputs so we can reference the private IP later
output firewallPrivateIp string = firewall.properties.ipConfigurations[0].properties.privateIPAddress
output firewallPublicIp string = fwPip.properties.ipAddress
