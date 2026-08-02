targetScope = 'tenant'

// Root management group for NexGen Tech – direct child of tenant root
resource mgRoot 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'mg-nexgen-root'
  properties: {
    displayName: 'NexGen Tech Root'
    details: {
      parent: {
        id: tenantResourceId('Microsoft.Management/managementGroups', tenant().tenantId)
      }
    }
  }
}

// Production workloads
resource mgProd 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'mg-nexgen-prod'
  properties: {
    displayName: 'NexGen Tech Production'
    details: {
      parent: {
        id: mgRoot.id
      }
    }
  }
}

// Non-production workloads (dev, test, staging)
resource mgNonProd 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'mg-nexgen-nonprod'
  properties: {
    displayName: 'NexGen Tech Non-Production'
    details: {
      parent: {
        id: mgRoot.id
      }
    }
  }
}

// Sandbox / experimentation
resource mgSandbox 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'mg-nexgen-sandbox'
  properties: {
    displayName: 'NexGen Tech Sandbox'
    details: {
      parent: {
        id: mgRoot.id   // now sits under mg-nexgen-root, not directly under tenant root
      }
    }
  }
}
