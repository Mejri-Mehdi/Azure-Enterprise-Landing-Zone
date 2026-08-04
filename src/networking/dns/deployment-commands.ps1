# Get VNet IDs
$hubVnetId = az network vnet show --name vnet-hub-eastus --resource-group rg-networking-hub --query id -o tsv
$prodVnetId = az network vnet show --name vnet-prod-eastus --resource-group rg-networking-spoke-prod --query id -o tsv
$devVnetId = az network vnet show --name vnet-dev-eastus --resource-group rg-networking-spoke-dev --query id -o tsv

# Deploy DNS zones and links to the hub resource group (central location)
az deployment group create `
  --resource-group rg-networking-hub `
  --template-file src/networking/dns/private-dns-zones.bicep `
  --parameters hubVnetId=$hubVnetId prodVnetId=$prodVnetId devVnetId=$devVnetId