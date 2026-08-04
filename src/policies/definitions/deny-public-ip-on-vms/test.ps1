az group create --name test-pip-policy --location eastus

# Create a VM with a public IP – this will fail due to the NIC creation
az vm create `
  --name testvm-withpip `
  --resource-group test-pip-policy `
  --image Win2022Datacenter `
  --admin-username azureuser `
  --admin-password "SuperSecret123!" `
  --public-ip-address ""  # leave empty to auto-generate PIP? Wait, this creates a public IP





az vm create `
  --name testvm-pip-fail `
  --resource-group test-pip-policy `
  --image Win2022Datacenter `
  --admin-username azureuser `
  --admin-password "SuperSecret123!" `
  --public-ip-address "test-pip-fail"




az vm create `
  --name testvm-nopip `
  --resource-group test-pip-policy `
  --image Win2022Datacenter `
  --admin-username azureuser `
  --admin-password "SuperSecret123!" `
  --public-ip-address "" `
  --nsg ""  # optional, just to avoid extra warnings




az vm create `
  --name testvm-nopip `
  --resource-group test-pip-policy `
  --image Win2022Datacenter `
  --admin-username azureuser `
  --admin-password "SuperSecret123!" `
  --public-ip-address "" `
  --public-ip-address-allocation "" 





az network public-ip create --name test-pip --resource-group test-pip-policy --location eastus
az network nic create `
  --name testnic-withpip `
  --resource-group test-pip-policy `
  --vnet-name test-vnet `
  --subnet default `
  --public-ip-address test-pip `
  --location eastus




az group delete --name test-pip-policy --yes
