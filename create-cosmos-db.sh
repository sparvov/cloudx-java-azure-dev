#!/bin/sh

az extension add --name serviceconnector-passwordless --upgrade

az cosmosdb create \
    --name ${COSMOS_DB_ACCOUNT_NAME} \
    --kind GlobalDocumentDB \
    --resource-group ${RESOURCE_GROUP}

az cosmosdb database create \
    --name ${COSMOS_DB_ACCOUNT_NAME} \
    --db-name ${COSMOS_DB_NAME} \
    --resource-group ${RESOURCE_GROUP} \
    --throughput 400

az cosmosdb collection create \
    --name ${COSMOS_DB_ACCOUNT_NAME} \
    --db-name ${COSMOS_DB_NAME} \
    --collection-name PestoreContainer \
    --resource-group ${RESOURCE_GROUP} \
    --partition-key-path /orderId \
    --throughput 400
