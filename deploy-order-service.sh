#!/bin/sh

echo "------------ Create ${ORDER_SERVICE_NAME}"
cd ./petstore/petstoreorderservice
az acr build --registry "${CONTAINER_REGISTRY}.azurecr.io" --image ${ORDER_SERVICE_IMAGE} .
az appservice plan create --name ${ORDER_SERVICE_SERVICE_PLAN} --resource-group ${RESOURCE_GROUP} --sku ${SERVICE_PLAN_SKU} --is-linux -l ${LOCATION}
az webapp create -n ${ORDER_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} -p "${ORDER_SERVICE_SERVICE_PLAN}" -i "${CONTAINER_REGISTRY}.azurecr.io/${ORDER_SERVICE_IMAGE}"
az webapp deployment container config --enable-cd true -g ${RESOURCE_GROUP} -n ${ORDER_SERVICE_SUBDOMAIN}
az webapp config appsettings set -g ${RESOURCE_GROUP} -n ${ORDER_SERVICE_SUBDOMAIN} --settings \
    PETSTOREPRODUCTSERVICE_URL="https://${ORDER_SERVICE_SUBDOMAIN}.azurewebsites.net/" \
    KEY_VAULT_ENDPOINT="https://${KEY_VAULT_NAME}.vault.azure.net" \
    COSMOS_URI="@Microsoft.KeyVault(VaultName=${KEY_VAULT_NAME};SecretName=${KEY_VAULT_SECRET_NAME_COSMOS_URI})" \
    COSMOS_PRIMARY_KEY="@Microsoft.KeyVault(VaultName=${KEY_VAULT_NAME};SecretName=${KEY_VAULT_SECRET_NAME_COSMOS_PRIMARY_KEY})" \
    COSMOS_SECONDARY_KEY="@Microsoft.KeyVault(VaultName=${KEY_VAULT_NAME};SecretName=${KEY_VAULT_SECRET_NAME_COSMOS_SECONDARY_KEY})" \
    COSMOS_DB_NAME="@Microsoft.KeyVault(VaultName=${KEY_VAULT_NAME};SecretName=${KEY_VAULT_SECRET_NAME_COSMOS_DB_NAME})"

#az webapp log tail --name ${ORDER_SERVICE_SUBDOMAIN} --resource-group ${RESOURCE_GROUP}
