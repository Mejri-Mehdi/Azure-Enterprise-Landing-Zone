az group create --name test-nsg-policy --location eastus
az network nsg create --name test-nsg --resource-group test-nsg-policy --location eastus

# This rule should be denied by policy
az network nsg rule create `
  --name "open-rdp-rule" `
  --nsg-name test-nsg `
  --resource-group test-nsg-policy `
  --priority 100 `
  --direction Inbound `
  --access Allow `
  --protocol Tcp `
  --source-address-prefixes "*" `
  --source-port-ranges "*" `
  --destination-address-prefixes "*" `
  --destination-port-ranges 3389




az network nsg rule create `
  --name "restricted-rdp" `
  --nsg-name test-nsg `
  --resource-group test-nsg-policy `
  --priority 101 `
  --direction Inbound `
  --access Allow `
  --protocol Tcp `
  --source-address-prefixes "10.0.0.0/16" `
  --source-port-ranges "*" `
  --destination-address-prefixes "*" `
  --destination-port-ranges 3389






az group delete --name test-nsg-policy --yes