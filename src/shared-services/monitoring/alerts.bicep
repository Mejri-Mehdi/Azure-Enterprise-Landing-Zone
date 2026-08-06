targetScope = 'resourceGroup'

param location string = 'eastus'
param emailAddress string

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: 'ag-nexgen-critical'
  location: 'Global'
  properties: {
    groupShortName: 'nxg-crit'
    enabled: true
    emailReceivers: [{
      name: 'admin-email'
      emailAddress: emailAddress
      useCommonAlertSchema: true
    }]
  }
}

// Alert when ANY resource group is deleted in the subscription
resource rgDeleteAlert 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: 'alert-rg-deletion'
  location: 'Global'
  properties: {
    scopes: ['/subscriptions/${subscription().subscriptionId}']
    condition: {
      allOf: [
        {
          field: 'category'
          equals: 'Administrative'
        }
        {
          field: 'operationName'
          equals: 'Microsoft.Resources/subscriptions/resourceGroups/delete'
        }
      ]
    }
    actions: {
      actionGroups: [{ actionGroupId: actionGroup.id }]
    }
    enabled: true
    description: 'Alert when a resource group is deleted'
  }
}

output actionGroupId string = actionGroup.id
