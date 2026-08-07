#!/bin/bash
# cleanup-environment.sh
# DESTROYS everything except the hub networking and shared services
# Use with caution!

echo "⚠️  This will delete all spoke and workload resource groups!"
read -p "Are you sure? Type 'destroy' to continue: " confirm

if [ "$confirm" != "destroy" ]; then
    echo "Aborted."
    exit 1
fi

# Delete workload RGs
az group delete --name rg-nexgen-dev --yes --no-wait
az group delete --name rg-nexgen-test --yes --no-wait
az group delete --name rg-nexgen-prod --yes --no-wait

# Delete test RGs (if any exist)
for rg in $(az group list --query "[?starts_with(name, 'rg-test-')].name" -o tsv); do
    echo "Deleting test RG: $rg"
    az group delete --name "$rg" --yes --no-wait
done

echo "Cleanup initiated. Check portal for progress."