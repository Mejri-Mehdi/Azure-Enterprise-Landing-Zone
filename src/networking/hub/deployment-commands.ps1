az group create --name rg-networking-hub --location eastus


---------------------------------------------------------------------------------------------------------------------------



az deployment group create `
  --resource-group rg-networking-hub `
  --template-file src/networking/hub/hub-vnet.bicep





---------------------------------------------------------------------------------------------------------------------------







































