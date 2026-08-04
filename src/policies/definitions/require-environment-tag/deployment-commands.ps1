az deployment mg create `
  --management-group-id mg-nexgen-root `
  --location eastus `
  --template-file src/policies/definitions/require-environment-tag/main.bicep




$mgRootId = (az account management-group show --name mg-nexgen-root --query id -o tsv)

az policy assignment create `
  --name "require-environment-tag-assignment" `
  --policy "require-environment-tag" `
  --scope $mgRootId