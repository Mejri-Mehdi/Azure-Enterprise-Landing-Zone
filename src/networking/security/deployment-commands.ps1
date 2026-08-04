az deployment group create `
  --resource-group rg-networking-spoke-prod `
  --template-file src/networking/security/nsg-rules.bicep



-----------------------------------------------------------------------------------------------------------------------------




# Web subnet
az network vnet subnet update `
  --name snet-web `
  --vnet-name vnet-prod-eastus `
  --resource-group rg-networking-spoke-prod `
  --network-security-group nsg-prod-web

# App subnet
az network vnet subnet update `
  --name snet-app `
  --vnet-name vnet-prod-eastus `
  --resource-group rg-networking-spoke-prod `
  --network-security-group nsg-prod-app

# DB subnet
az network vnet subnet update `
  --name snet-db `
  --vnet-name vnet-prod-eastus `
  --resource-group rg-networking-spoke-prod `
  --network-security-group nsg-prod-db