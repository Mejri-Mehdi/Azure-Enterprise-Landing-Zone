# 1. Deploy the initiative definition to mg-nexgen-root
az deployment mg create `
  --management-group-id mg-nexgen-root `
  --location eastus `
  --template-file src/policies/initiatives/nexgen-secure-baseline/main.bicep

# 2. Assign the initiative to the root management group
az policy assignment create `
  --name "nexgen-baseline-assignment" `
  --policy-set-definition "nexgen-secure-baseline" `
  --scope "/providers/Microsoft.Management/managementGroups/mg-nexgen-root" `
  --location eastus