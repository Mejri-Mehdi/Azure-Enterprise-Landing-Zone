#!/bin/bash
# policy-compliance-check.sh
# Quick compliance report from CLI

echo "=== NexGen Policy Compliance Report ==="
echo ""

MG_ID="/providers/Microsoft.Management/managementGroups/mg-nexgen-root"

# Overall compliance summary
az policy state summarize --management-group "$MG_ID" --query 'value[0].results' -o table

# Non-compliant resources
echo ""
echo "=== Non-Compliant Resources (Top 20) ==="
az policy state list --management-group "$MG_ID" \
  --filter "properties/complianceState eq 'NonCompliant'" \
  --query '[*].{Resource:resourceId, Policy:policyDefinitionName, State:complianceState}' \
  -o table | head -20