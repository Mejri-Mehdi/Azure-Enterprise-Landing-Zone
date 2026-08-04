az policy definition create `
  --name "require-costcenter-tag" `
  --display-name "Require CostCenter tag on all resources" `
  --rules "src/policies/definitions/require-costcenter-tag/policy-rule.json" `
  --params "src/policies/definitions/require-costcenter-tag/policy-params.json"






# Get the full management group ID
$mgRootId = (az account management-group show --name mg-nexgen-root --query id -o tsv)

az policy assignment create `
  --name "require-costcenter-tag-assignment" `
  --policy "require-costcenter-tag" `
  --scope $mgRootId