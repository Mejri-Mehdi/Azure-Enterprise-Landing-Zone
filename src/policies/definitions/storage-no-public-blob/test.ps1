az group create --name test-blob-policy --location eastus
az storage account create `
  --name testblobpublic1 `
  --resource-group test-blob-policy `
  --location eastus `
  --sku Standard_LRS `
  --allow-blob-public-access true `
  --tags CostCenter=CC123 Environment=Dev





az storage account create `
  --name testblobprivate1 `
  --resource-group test-blob-policy `
  --location eastus `
  --sku Standard_LRS `
  --allow-blob-public-access false `
  --tags CostCenter=CC123 Environment=Dev




az group delete --name test-blob-policy --yes