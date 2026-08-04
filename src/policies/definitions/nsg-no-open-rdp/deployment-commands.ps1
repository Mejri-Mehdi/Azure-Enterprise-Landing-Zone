# 1. Deploy policy definition to mg-nexgen-root
az deployment mg create `
  --management-group-id mg-nexgen-root `
  --location eastus `
  --template-file src/policies/definitions/nsg-no-open-rdp/main.bicep

# 2. Assign it at the same scope
$mgRootId = (az account management-group show --name mg-nexgen-root --query id -o tsv)

az policy assignment create `
  --name "nsg-no-open-rdp-assignment" `
  --policy "nsg-no-open-rdp" `
  --scope $mgRootId