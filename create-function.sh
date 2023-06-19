#!/bin/sh

echo "------------ Create Function"
az functionapp create \
    --resource-group ${RESOURCE_GROUP} \
    --name ${FUNCTION_NAME} \
    --storage-account ${STORAGE_ACCOUNT} \
    --runtime java \
    --runtime-version 11 \
    --functions-version 4 \
    --consumption-plan-location ${LOCATION}

echo "----- Connect to Service Bus"
SERVICE_BUS_CONNECTION_STRING=$(az servicebus namespace authorization-rule keys list \
    --resource-group ${RESOURCE_GROUP} \
    --namespace-name ${NAMESPACE} \
    --name RootManageSharedAccessKey \
    --query primaryConnectionString \
    --output tsv)

echo ${SERVICE_BUS_CONNECTION_STRING}

echo "----- Connect to Storage Account"
STORAGE_CONNECTION_STRING=$(az storage account show-connection-string \
    --name ${STORAGE_ACCOUNT} \
    --resource-group ${RESOURCE_GROUP} \
    --output tsv)

echo ${STORAGE_CONNECTION_STRING}

az functionapp config appsettings set \
    --name ${FUNCTION_NAME} \
    --resource-group ${RESOURCE_GROUP} \
    --settings "serviceBusConnectionString=${SERVICE_BUS_CONNECTION_STRING}" \
               "storageConnectionString=${STORAGE_CONNECTION_STRING}" \
               "storageContainer=${STORAGE_CONTAINER}"

echo "----- Deploy Function"
cd order-items-reserver
mvn clean package azure-functions:deploy
