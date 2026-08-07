az group create --name rg-test-sql --location eastus


$subnetId = az network vnet subnet show `
  --name snet-dev-default `
  --vnet-name vnet-dev-eastus `
  --resource-group rg-networking-spoke-dev `
  --query id -o tsv



az deployment group create `
  --resource-group rg-test-sql `
  --template-file src/modules/database/sql-server/main.bicep `
  --parameters sqlServerName=sql-nexgen-dev subnetId=$subnetId adminPassword='YourSecurePass123!'