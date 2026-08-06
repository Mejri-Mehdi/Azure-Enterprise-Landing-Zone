az group create --name rg-shared-services-hub --location eastus


az deployment group create `
  --resource-group rg-shared-services-hub `
  --template-file src/shared-services/monitoring/log-analytics.bicep





--------------------------------------------------------------------------------------------------------------------------



# Ensure the resource group exists
az group create --name rg-shared-services-hub --location eastus   # skip if already exists

az deployment group create `
  --resource-group rg-shared-services-hub `
  --template-file src/shared-services/monitoring/alerts.bicep `
  --parameters emailAddress='your-email@example.com'   # replace with your real email
