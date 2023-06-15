#!/bin/sh

service_subdomain=$1

az webapp identity assign \
    --resource-group ${RESOURCE_GROUP} \
    --name ${service_subdomain}

IDENTITY_PRINCIPAL_ID=$(az webapp identity show \
    --resource-group ${RESOURCE_GROUP} \
    --name ${service_subdomain} \
    --query principalId -o tsv)

az keyvault set-policy \
    --name ${KEY_VAULT_NAME} \
    --object-id ${IDENTITY_PRINCIPAL_ID} \
    --secret-permissions get list
