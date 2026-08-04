az group create --name rg-networking-spoke-prod --location eastus
az group create --name rg-networking-spoke-dev --location eastus



az deployment group create `
  --resource-group rg-networking-spoke-prod `
  --template-file src/networking/spokes/spoke-vnet.bicep `
  --parameters spokeName=prod addressPrefix='10.1.0.0/16'




az deployment group create `
  --resource-group rg-networking-spoke-dev `
  --template-file src/networking/spokes/spoke-vnet.bicep `
  --parameters spokeName=dev addressPrefix='10.2.0.0/16'