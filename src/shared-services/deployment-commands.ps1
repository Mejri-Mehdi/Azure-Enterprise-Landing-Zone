az deployment sub create `
  --location eastus `
  --template-file src/shared-services/main.bicep `
  --parameters emailAddress='your-email@example.com'