targetScope = 'managementGroup'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'storage-no-public-blob'
  properties: {
    displayName: 'Storage accounts must disable public blob access'
    description: 'Prevents anonymous public access to blob containers'
    policyType: 'Custom'
    mode: 'Indexed'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Storage/storageAccounts'
          }
          {
            field: 'Microsoft.Storage/storageAccounts/allowBlobPublicAccess'
            equals: 'true'
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}
