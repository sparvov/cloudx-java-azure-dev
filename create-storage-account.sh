#!/bin/sh

az storage account create \
    --name ${STORAGE_ACCOUNT} \
    --resource-group ${RESOURCE_GROUP} \
    --location ${LOCATION} \
    --sku Standard_LRS

STORAGE_CONNECTION_STRING=$(az storage account show-connection-string \
    --name ${STORAGE_ACCOUNT} \
    --resource-group ${RESOURCE_GROUP} \
    --output tsv)

echo ${STORAGE_CONNECTION_STRING}

echo "------------ Create container"
success=false
max_retries=10
retry_delay=10  # seconds

for ((i=0; i<max_retries; i++)); do
    az storage container create \
        --name "${STORAGE_CONTAINER}" \
        --connection-string "${STORAGE_CONNECTION_STRING}"

    if [ $? -eq 0 ]; then
        success=true
        break
    else
        echo "Error occurred while creating the storage container. Retrying in ${retry_delay} seconds..."
        sleep $retry_delay
    fi
done

if ! $success; then
    echo "Failed to create the storage container after ${max_retries} attempts."
fi



