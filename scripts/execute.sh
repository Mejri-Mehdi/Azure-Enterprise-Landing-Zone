# Make scripts executable
chmod +x scripts/utility/cleanup-environment.sh
chmod +x scripts/validate/policy-compliance-check.sh

# Test compliance check (you must be logged in to Azure)
./scripts/validate/policy-compliance-check.sh