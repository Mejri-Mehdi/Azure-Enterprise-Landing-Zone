targetScope = 'managementGroup'

// Use extensionResourceId to build the definition ID from the current management group scope
var requireCostCenterTagId = extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'require-costcenter-tag')
var requireEnvironmentTagId = extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'require-environment-tag')
var allowedLocationsId = extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'allowed-locations')
var denyPublicIpId = extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'deny-public-ip-on-vms')
var storageNoPublicBlobId = extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'storage-no-public-blob')
var nsgNoOpenRdpId = extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'nsg-no-open-rdp')
var keyvaultSoftDeleteId = extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'keyvault-soft-delete')

resource initiative 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'nexgen-secure-baseline'
  properties: {
    displayName: 'NexGen Secure Baseline Initiative'
    description: 'Core governance policies for all NexGen environments. Deploys tagging, location, security, and compliance controls.'
    policyType: 'Custom'
    parameters: {
      allowedLocations: {
        type: 'Array'
        defaultValue: ['eastus', 'westus2']
        metadata: {
          description: 'List of approved Azure regions'
          displayName: 'Allowed Locations'
        }
      }
    }
    policyDefinitions: [
      {
        policyDefinitionId: requireCostCenterTagId
        parameters: {}
      }
      {
        policyDefinitionId: requireEnvironmentTagId
        parameters: {}
      }
      {
        policyDefinitionId: allowedLocationsId
        parameters: {
          allowedLocations: {
            value: '[parameters(\'allowedLocations\')]'
          }
        }
      }
      {
        policyDefinitionId: denyPublicIpId
        parameters: {}
      }
      {
        policyDefinitionId: storageNoPublicBlobId
        parameters: {}
      }
      {
        policyDefinitionId: nsgNoOpenRdpId
        parameters: {}
      }
      {
        policyDefinitionId: keyvaultSoftDeleteId
        parameters: {}
      }
    ]
  }
}
