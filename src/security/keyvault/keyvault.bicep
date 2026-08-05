targetScope = 'resourceGroup'

param location string = 'eastus'

resource kv 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'kv-nexgen-hub-eastus'
  location: location
  properties: {
    sku: { family: 'A', name: 'standard' }
    tenantId: subscription().tenantId
    enableSoftDelete: true
    enablePurgeProtection: true
    enableRbacAuthorization: true
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}

// Customer-Managed Key for storage encryption
resource cmkKey 'Microsoft.KeyVault/vaults/keys@2023-07-01' = {
  parent: kv
  name: 'cmk-storage-encryption'
  properties: {
    kty: 'RSA'
    keySize: 2048
    keyOps: ['encrypt', 'decrypt', 'wrapKey', 'unwrapKey']
  }
}

output kvId string = kv.id
output kvName string = kv.name
output kvUri string = kv.properties.vaultUri
output cmkKeyId string = cmkKey.id
