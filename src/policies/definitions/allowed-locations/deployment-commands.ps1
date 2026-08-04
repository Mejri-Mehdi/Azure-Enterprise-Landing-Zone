# 1. Deploy the definition to mg-nexgen-root
az deployment mg create `
  --management-group-id mg-nexgen-root `
  --location eastus `
  --template-file src/policies/definitions/allowed-locations/main.bicep

# 2. Assign the policy at the same scope
$mgRootId = (az account management-group show --name mg-nexgen-root --query id -o tsv)

az policy assignment create `
  --name "allowed-locations-assignment" `
  --policy "allowed-locations" `
  --scope $mgRootId