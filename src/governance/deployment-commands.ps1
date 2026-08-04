az deployment tenant create ``
  --location eastus `
  --template-file src/governance/management-groups.bicep




--------------------------------------------------------------------------------------------------------------------------



az deployment tenant create `
  --location eastus `
  --template-file src/governance/management-groups.bicep




--------------------------------------------------------------------------------------------------------------------------



az deployment tenant create `
  --location eastus `
  --template-file src/governance/management-groups.bicep




--------------------------------------------------------------------------------------------------------------------------




az deployment sub create `
  --location eastus `
  --template-file src/governance/custom-roles.bicep




--------------------------------------------------------------------------------------------------------------------------




az deployment sub create `
  --location eastus `
  --template-file src/governance/budgets.bicep `
  --parameters budgetAlertEmail='your.real@email.com'






















