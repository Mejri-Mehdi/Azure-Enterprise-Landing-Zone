targetScope = 'managementGroup'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'deny-public-ip-on-vms'
  properties: {
    displayName: 'Deny public IP addresses on VMs'
    description: 'Prevents VMs from having a public IP to enforce Bastion-only access'
    policyType: 'Custom'
    mode: 'Indexed'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Network/networkInterfaces'
          }
          {
            field: 'Microsoft.Network/networkInterfaces/ipConfigurations[*].publicIpAddress.id'
            exists: 'true'
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}
