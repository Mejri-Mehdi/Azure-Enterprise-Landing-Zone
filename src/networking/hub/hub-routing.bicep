targetScope = 'resourceGroup'

param location string = 'eastus'
param firewallPrivateIp string

resource routeTable 'Microsoft.Network/routeTables@2023-05-01' = {
  name: 'rt-hub-shared-svc'
  location: location
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'route-to-firewall'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: firewallPrivateIp
        }
      }
    ]
  }
}
