# 1. Deploy policy definition to mg-nexgen-root
az deployment mg create `
  --management-group-id mg-nexgen-root `
  --location eastus `
  --template-file src/policies/definitions/storage-no-public-blob/main.bicep

# 2. Assign it at the same scope
$mgRootId = (az account management-group show --name mg-nexgen-root --query id -o tsv)

az policy assignment create `
  --name "storage-no-public-blob-assignment" `
  --policy "storage-no-public-blob" `
  --scope $mgRootId