#!/bin/bash
set -euo pipefail

# Usage: ./what-if.sh <template-file> <deployment-name> <location>
TEMPLATE=${1:-src/governance/management-groups.bicep}
DEPLOYMENT_NAME=${2:-whatif-mg}
LOCATION=${3:-eastus}

echo "Running what-if deployment for: $TEMPLATE"
echo "Deployment name: $DEPLOYMENT_NAME"
echo "Location: $LOCATION"

az deployment tenant what-if \
  --name "$DEPLOYMENT_NAME" \
  --location "$LOCATION" \
  --template-file "$TEMPLATE"