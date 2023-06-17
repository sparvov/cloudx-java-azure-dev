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

az keyvault secret set \
    --vault-name ${KEY_VAULT_NAME} \
    --name ${KEY_VAULT_SECRET_NAME_COSMOS_URI} \
    --value "${COSMOS_URI}"

az keyvault secret set \
    --vault-name ${KEY_VAULT_NAME} \
    --name ${KEY_VAULT_SECRET_NAME_COSMOS_DB_NAME} \
    --value "${COSMOS_DB_NAME}"

cosmosPrimaryKey=$(az cosmosdb keys list --name ${COSMOS_DB_ACCOUNT_NAME} --resource-group ${RESOURCE_GROUP} --query 'primaryMasterKey' --output tsv)
cosmosSecondaryKey=$(az cosmosdb keys list --name ${COSMOS_DB_ACCOUNT_NAME} --resource-group ${RESOURCE_GROUP} --query 'secondaryMasterKey' --output tsv)

az keyvault secret set \
    --vault-name ${KEY_VAULT_NAME} \
    --name ${KEY_VAULT_SECRET_NAME_COSMOS_PRIMARY_KEY} \
    --value "${cosmosPrimaryKey}"

az keyvault secret set \
    --vault-name ${KEY_VAULT_NAME} \
    --name ${KEY_VAULT_SECRET_NAME_COSMOS_SECONDARY_KEY} \
    --value "${cosmosSecondaryKey}"
