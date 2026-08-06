az group create --name rg-shared-services-hub --location eastus   # only if it doesn't exist

az deployment group create `
  --resource-group rg-shared-services-hub `
  --template-file src/shared-services/container-registry/acr.bicep