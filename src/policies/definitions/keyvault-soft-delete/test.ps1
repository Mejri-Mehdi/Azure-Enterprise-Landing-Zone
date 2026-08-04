az group create --name test-kv-policy --location eastus
az keyvault create `
  --name "testkvsoftfail1" `
  --resource-group test-kv-policy `
  --location eastus `
  --enable-soft-delete false `
  --tags CostCenter=CC123 Environment=Dev




az keyvault create `
  --name "testkvsoftpass1" `
  --resource-group test-kv-policy `
  --location eastus `
  --enable-soft-delete true `
  --tags CostCenter=CC123 Environment=Dev



az group delete --name test-kv-policy --yes