targetScope = 'resourceGroup'

param location string = 'eastus'

// IMPORTANT: Change 'acrnexgenhub' to a globally unique name.
// Use a combination of your initials, project, and date, e.g., 'acrnexgenhub2025xyz'.
resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: 'acrnexgenhub'   // <-- REPLACE THIS with a unique value before deploying
  location: location
  sku: { name: 'Standard' }
  properties: {
    adminUserEnabled: false                 // Entra ID authentication only
    publicNetworkAccess: 'Enabled'          // change to 'Disabled' for private‑endpoint use later
    networkRuleBypassOptions: 'AzureServices'
  }
}

output acrId string = acr.id
output acrName string = acr.name
output acrLoginServer string = acr.properties.loginServer
