targetScope = 'managementGroup'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'require-environment-tag'
  properties: {
    displayName: 'Require Environment tag with allowed values'
    description: 'All resources must have an Environment tag set to Dev, Test, Prod, or Sandbox'
    policyType: 'Custom'
    mode: 'Indexed'
    parameters: {
      allowedEnvironments: {
        type: 'Array'
        defaultValue: ['Dev', 'Test', 'Prod', 'Sandbox']
        metadata: {
          description: 'Allowed environment values'
          displayName: 'Allowed Environments'
        }
      }
    }
    policyRule: {
      if: {
        anyOf: [
          {
            field: 'tags[\'Environment\']'
            exists: 'false'
          }
          {
            not: {
              field: 'tags[\'Environment\']'
              in: '[parameters(\'allowedEnvironments\')]'
            }
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}
