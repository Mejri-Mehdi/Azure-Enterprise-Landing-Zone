az group create --name rg-networking-hub --location eastus


---------------------------------------------------------------------------------------------------------------------------



az deployment group create `
  --resource-group rg-networking-hub `
  --template-file src/networking/hub/hub-vnet.bicep





---------------------------------------------------------------------------------------------------------------------------




az deployment group create `
  --resource-group rg-networking-hub `
  --template-file src/networking/hub/azure-bastion.bicep





---------------------------------------------------------------------------------------------------------------------------




az deployment group create `
  --resource-group rg-networking-hub `
  --template-file src/networking/hub/azure-firewall.bicep



$fwPrivateIp = (az deployment group show `
  --resource-group rg-networking-hub `
  --name azure-firewall `
  --query properties.outputs.firewallPrivateIp.value -o tsv)

az deployment group create `
  --resource-group rg-networking-hub `
  --template-file src/networking/hub/hub-routing.bicep `
  --parameters firewallPrivateIp=$fwPrivateIp



# Get the subnet ID and attach the route table
$vnetName = "vnet-hub-eastus"
$subnetName = "snet-shared-svc"

az network vnet subnet update `
  --resource-group rg-networking-hub `
  --vnet-name $vnetName `
  --name $subnetName `
  --route-table rt-hub-shared-svc



-----------------------------------------------------------------------------------------------------------------------------





$hubVnetId = az network vnet show --name vnet-hub-eastus --resource-group rg-networking-hub --query id -o tsv
$spokeProdVnetId = az network vnet show --name vnet-prod-eastus --resource-group rg-networking-spoke-prod --query id -o tsv
$spokeDevVnetId = az network vnet show --name vnet-dev-eastus --resource-group rg-networking-spoke-dev --query id -o tsv




az deployment group create `
  --resource-group rg-networking-hub `
  --template-file src/networking/hub/hub-peering.bicep `
  --parameters spokeProdVnetId=$spokeProdVnetId spokeDevVnetId=$spokeDevVnetId






















