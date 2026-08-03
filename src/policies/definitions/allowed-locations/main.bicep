targetScope = 'managementGroup'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'allowed-locations'
  properties: {
    displayName: 'Allowed Azure Regions'
    description: 'Restrict resource deployment to approved regions only'
    policyType: 'Custom'
    mode: 'Indexed'
    parameters: {
      allowedLocations: {
        type: 'Array'
        defaultValue: ['eastus', 'westus2']
        metadata: {
          description: 'The list of allowed locations for resources.'
          strongType: 'location'
          displayName: 'Allowed locations'
        }
      }
    }
    policyRule: {
      if: {
        not: {
          field: 'location'
          in: '[parameters(\'allowedLocations\')]'
        }
      }
      then: {
        effect: 'deny'
      }
    }
  }
}
