az group create --name rg-test-appsvc --location eastus

$subnetId = az network vnet subnet show `
  --name snet-dev-default `
  --vnet-name vnet-dev-eastus `
  --resource-group rg-networking-spoke-dev `
  --query id -o tsv




az deployment group create `
  --resource-group rg-test-appsvc `
  --template-file src/modules/compute/app-service/main.bicep `
  --parameters appName=nexgen-test-app subnetId=$subnetId