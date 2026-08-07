az group create --name rg-test-module --location eastus

$subnetId = az network vnet subnet show `
  --name snet-dev-default `
  --vnet-name vnet-dev-eastus `
  --resource-group rg-networking-spoke-dev `
  --query id -o tsv


az deployment group create `
  --resource-group rg-test-module `
  --template-file src/modules/compute/linux-vm/main.bicep `
  --parameters vmName=vm-test-module subnetId=$subnetId adminPassword='YourSecurePass123!'