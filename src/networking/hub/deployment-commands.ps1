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



---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------




























