targetScope = 'managementGroup'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'keyvault-soft-delete'
  properties: {
    displayName: 'Key Vault must have soft delete enabled'
    description: 'Ensures deleted keys/secrets can be recovered for 90 days'
    policyType: 'Custom'
    mode: 'Indexed'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.KeyVault/vaults'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.KeyVault/vaults/enableSoftDelete'
                exists: 'false'
              }
              {
                field: 'Microsoft.KeyVault/vaults/enableSoftDelete'
                equals: 'false'
              }
            ]
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}
