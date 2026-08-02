targetScope = 'subscription'

@description('Email address that receives budget alerts')
param budgetAlertEmail string = 'mehdimejri15@gmail.com'

// ── Action Group for Budget Alerts ──────────────────────
resource actionGroup 'Microsoft.Insights/actionGroups@2023-06-01' = {
  name: 'ag-budget-alerts'
  location: 'global'   // action groups are global resources
  properties: {
    groupShortName: 'budgetalerts'
    enabled: true
    emailReceivers: [
      {
        name: 'AdminEmail'
        emailAddress: budgetAlertEmail
        useCommonAlertSchema: true
      }
    ]
  }
}

// ── Budget for Non‑Production ──────────────────────────
resource budgetNonProd 'Microsoft.Consumption/budgets@2023-03-01' = {
  name: 'budget-nonprod'
  properties: {
    amount: 50
    timeGrain: 'Monthly'
    category: 'Cost'
    notifications: {
      Actual_GreaterThan_50_Percent: {
        enabled: true
        operator: 'GreaterThan'
        threshold: 50
        contactEmails: []
        contactGroups: [ actionGroup.id ]
      }
      Actual_GreaterThan_80_Percent: {
        enabled: true
        operator: 'GreaterThan'
        threshold: 80
        contactEmails: []
        contactGroups: [ actionGroup.id ]
      }
      Actual_GreaterThan_100_Percent: {
        enabled: true
        operator: 'GreaterThan'
        threshold: 100
        contactEmails: []
        contactGroups: [ actionGroup.id ]
      }
    }
  } 
}

// ── Budget for Production ──────────────────────────────
resource budgetProd 'Microsoft.Consumption/budgets@2023-03-01' = {
  name: 'budget-prod'
  properties: {
    amount: 100
    timeGrain: 'Monthly'
    category: 'Cost'
    notifications: {
      Actual_GreaterThan_50_Percent: {
        enabled: true
        operator: 'GreaterThan'
        threshold: 50
        contactEmails: []
        contactGroups: [ actionGroup.id ]
      }
      Actual_GreaterThan_80_Percent: {
        enabled: true
        operator: 'GreaterThan'
        threshold: 80
        contactEmails: []
        contactGroups: [ actionGroup.id ]
      }
      Actual_GreaterThan_100_Percent: {
        enabled: true
        operator: 'GreaterThan'
        threshold: 100
        contactEmails: []
        contactGroups: [ actionGroup.id ]
      }
    }
  }
}
