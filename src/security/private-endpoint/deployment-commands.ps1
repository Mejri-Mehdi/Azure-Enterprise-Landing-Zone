
az deployment group create `
  --resource-group rg-shared-services-hub `
  --template-file src/security/private-endpoints/keyvault-pe.bicep




az keyvault update `
  --name kv-nexgen-hub-eastus `
  --resource-group rg-shared-services-hub `
  --public-network-access Disabled


