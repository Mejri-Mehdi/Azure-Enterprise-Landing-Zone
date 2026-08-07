param appName string
param location string = resourceGroup().location
param subnetId string           // For VNet integration
param environment string = 'dev'
param sku string = 'S1'

resource plan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'plan-${appName}'
  location: location
  tags: {
    Environment: environment
    CostCenter: 'shared'
    Owner: 'platform-team'
  }
  sku: { name: sku }
  properties: {}
}

resource app 'Microsoft.Web/sites@2022-09-01' = {
  name: appName
  location: location
  tags: {
    Environment: environment
    CostCenter: 'shared'
    Owner: 'platform-team'
  }
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
    siteConfig: {
      alwaysOn: true
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
    }
  }
}

resource vnetIntegration 'Microsoft.Web/sites/networkConfig@2022-09-01' = {
  parent: app
  name: 'virtualNetwork'          // required name for regional VNet integration
  properties: {
    subnetResourceId: subnetId
  }
}

output appUrl string = 'https://${app.properties.defaultHostName}'
output appId string = app.id
