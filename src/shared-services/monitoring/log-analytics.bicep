targetScope = 'resourceGroup'

param location string = 'eastus'

resource law 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: 'law-nexgen-hub-eastus'
  location: location
  properties: {
    sku: { name: 'PerGB2018' }
    retentionInDays: 30
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
  }
}

output lawId string = law.id
output lawName string = law.name
output lawCustomerId string = law.properties.customerId
