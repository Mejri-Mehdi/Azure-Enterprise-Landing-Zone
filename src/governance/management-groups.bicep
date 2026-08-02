targetScope = 'tenant'

resource mgSandbox 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'mg-nexgen-sandbox'
  properties: {
    displayName: 'NexGen Tech Sandbox Management Group'
    details: {
      parent: {
        id: tenantResourceId('Microsoft.Management/managementGroups', tenant().tenantId)
      }
    }
  }
}
 