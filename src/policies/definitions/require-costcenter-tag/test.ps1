az group create --name test-policy-rg --location eastus
az storage account create --name testcostcenterfail1 --resource-group test-policy-rg --location eastus --sku Standard_LRS




az storage account create --name testcostcenterpass1 --resource-group test-policy-rg --location eastus --sku Standard_LRS --tags CostCenter=CC123




az group delete --name test-policy-rg --yes