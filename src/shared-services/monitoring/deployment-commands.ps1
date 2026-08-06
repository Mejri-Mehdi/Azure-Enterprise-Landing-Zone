az group create --name rg-shared-services-hub --location eastus


az deployment group create `
  --resource-group rg-shared-services-hub `
  --template-file src/shared-services/monitoring/log-analytics.bicep

