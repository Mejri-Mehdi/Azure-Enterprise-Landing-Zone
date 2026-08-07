az deployment sub create `
  --location eastus `
  --template-file src/environments/dev-environment.bicep `
  --parameters adminPassword='YourSecurePass123!'