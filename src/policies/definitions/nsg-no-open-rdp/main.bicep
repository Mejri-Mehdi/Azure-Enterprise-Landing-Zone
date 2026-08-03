targetScope = 'managementGroup'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'nsg-no-open-rdp'
  properties: {
    displayName: 'NSG must not allow unrestricted RDP'
    description: 'Denies NSG rules that allow RDP (3389) from any source'
    policyType: 'Custom'
    mode: 'All'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Network/networkSecurityGroups/securityRules'
          }
          {
            field: 'Microsoft.Network/networkSecurityGroups/securityRules/destinationPortRange'
            equals: '3389'
          }
          {
            field: 'Microsoft.Network/networkSecurityGroups/securityRules/sourceAddressPrefix'
            equals: '*'
          }
          {
            field: 'Microsoft.Network/networkSecurityGroups/securityRules/access'
            equals: 'Allow'
          }
          {
            field: 'Microsoft.Network/networkSecurityGroups/securityRules/direction'
            equals: 'Inbound'
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}
