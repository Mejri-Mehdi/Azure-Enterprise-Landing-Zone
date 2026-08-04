az group create --name test-env-policy --location eastus
az storage account create --name testenvfail1 --resource-group test-env-policy --location eastus --sku Standard_LRS --tags Environment=Staging




az storage account create --name testenvfail2 --resource-group test-env-policy --location eastus --sku Standard_LRS --tags CostCenter=CC123




az storage account create --name testenvpass1 --resource-group test-env-policy --location eastus --sku Standard_LRS --tags Environment=Dev CostCenter=CC123




az group delete --name test-env-policy --yes