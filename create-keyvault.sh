#!/bin/sh

az keyvault purge --name ${KEY_VAULT_NAME}  --location ${LOCATION}

az keyvault create \
    --name ${KEY_VAULT_NAME} \
    --resource-group ${RESOURCE_GROUP} \
    --location ${LOCATION}

az keyvault secret set \
    --vault-name ${KEY_VAULT_NAME} \
    --name ${KEY_VAULT_SECRET_NAME_DB_URL} \
    --value "${DATASOURCE_DB_URL}"

az keyvault secret set \
    --vault-name ${KEY_VAULT_NAME} \
    --name ${KEY_VAULT_SECRET_NAME_DB_USERNAME} \
    --value "${DATASOURCE_DB_USERNAME}"

az keyvault secret set \
    --vault-name ${KEY_VAULT_NAME} \
    --name ${KEY_VAULT_SECRET_NAME_DB_PASSWORD} \
    --value "${DATASOURCE_DB_PASSWORD}"

