az group create --name test-location-policy --location westeurope
# This should FAIL with a policy violation
az storage account create --name testlocfail1 --resource-group test-location-policy --location westeurope --sku Standard_LRS --tags CostCenter=CC123 Environment=Dev




az group create --name test-location-policy-east --location eastus
az storage account create --name testlocpass1 --resource-group test-location-policy-east --location eastus --sku Standard_LRS --tags CostCenter=CC123 Environment=Dev
# This should succeed



az group create --name test-location-policy-west --location westus2
az storage account create --name testlocpass2 --resource-group test-location-policy-west --location westus2 --sku Standard_LRS --tags CostCenter=CC123 Environment=Dev




az group delete --name test-location-policy-east --yes
az group delete --name test-location-policy-west --yes