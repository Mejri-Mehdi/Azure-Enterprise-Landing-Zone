targetScope = 'resourceGroup'

param location string = 'eastus'

// Spoke VNet IDs (passed at deployment time)
param spokeProdVnetId string
param spokeDevVnetId string

// Hub VNet name (we are inside its RG, so we can use it directly)
var hubVnetName = 'vnet-hub-eastus'

// Peer to Prod
resource hubToProd 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-05-01' = {
  name: '${hubVnetName}/peer-hub-to-prod'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: true     // hub can be gateway
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: spokeProdVnetId
    }
  }
}

// Peer to Dev
resource hubToDev 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-05-01' = {
  name: '${hubVnetName}/peer-hub-to-dev'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: true
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: spokeDevVnetId
    }
  }
}
