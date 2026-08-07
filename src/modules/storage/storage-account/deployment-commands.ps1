az group create --name rg-test-stg --location eastus

$subnetId = az network vnet subnet show `
  --name snet-dev-default `
  --vnet-name vnet-dev-eastus `
  --resource-group rg-networking-spoke-dev `
  --query id -o tsv


az deployment group create `
  --resource-group rg-test-stg `
  --template-file src/modules/storage/storage-account/main.bicep `
  --parameters storageAccountName=stnexgendev001 subnetId=$subnetId