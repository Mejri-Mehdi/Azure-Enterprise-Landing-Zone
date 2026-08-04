# Variables
$rg = "rg-networking-hub"
$vnetName = "vnet-hub-eastus"
$subnetName = "snet-shared-svc"
$vmName = "testvm-bastion"
$adminUser = "azureuser"
$adminPassword = "SuperSecret123!"   # change to something secure

# Create the VM (no public IP)
az vm create `
  --resource-group $rg `
  --name $vmName `
  --image Win2022Datacenter `
  --vnet-name $vnetName `
  --subnet $subnetName `
  --admin-username $adminUser `
  --admin-password $adminPassword `
  --public-ip-address "" `
  --nsg ""   # we'll rely on subnet NSG (or none for now)





az vm delete --name $vmName --resource-group $rg --yes
az network nic delete --name ${vmName}VMNic --resource-group $rg
az disk delete --name ${vmName}_OsDisk_1_* --resource-group $rg   # grab exact name from portal