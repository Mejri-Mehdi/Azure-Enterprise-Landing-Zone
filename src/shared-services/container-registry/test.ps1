# Login using Azure AD (no admin password needed)
az acr login --name <your-unique-acr-name>

# Pull a tiny image and re-tag for your registry
docker pull hello-world
docker tag hello-world <your-acr-name>.azurecr.io/hello-world:v1

# Push the image
docker push <your-acr-name>.azurecr.io/hello-world:v1

# Verify it's there
az acr repository list --name <your-acr-name> --output table