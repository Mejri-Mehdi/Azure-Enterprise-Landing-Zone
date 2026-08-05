
# Create resource group for shared services
az group create --name rg-shared-services-hub --location eastus

# Deploy Key Vault and CMK key
az deployment group create `
  --resource-group rg-shared-services-hub `
  --template-file src/security/keyvault/keyvault.bicep