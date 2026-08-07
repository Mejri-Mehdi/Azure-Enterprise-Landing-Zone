param storageAccountName string
param location string = resourceGroup().location
param environment string = 'dev'
param subnetId string   // VNet service endpoint (not private endpoint yet)

resource stg 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  tags: {
    Environment: environment
    CostCenter: 'shared'
    Owner: 'platform-team'
  }
  sku: { name: 'Standard_LRS' }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      virtualNetworkRules: [
        {
          virtualNetworkResourceId: subnetId   // only traffic from this subnet via service endpoint
          action: 'Allow'
        }
      ]
    }
  }
}

// Pre‑create a blob container named 'data'
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  name: '${stg.name}/default/data'
  properties: {
    publicAccess: 'None'
  }
}

output storageId string = stg.id
output storageEndpoint string = stg.properties.primaryEndpoints.blob
