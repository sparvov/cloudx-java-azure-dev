#!/bin/sh

SERVICE_BUS_CONNECTION_STRING=$(az servicebus namespace authorization-rule keys list \
    --resource-group ${RESOURCE_GROUP} \
    --namespace-name ${NAMESPACE} \
    --name RootManageSharedAccessKey \
    --query primaryConnectionString \
    --output tsv)

echo ${SERVICE_BUS_CONNECTION_STRING}

az webapp config appsettings set -g ${RESOURCE_GROUP} -n ${WEP_APP_SUBDOMAIN_EASTUS} --settings \
  "namespace=${NAMESPACE}" \
  "orderPlacedQueue=${ORDER_PLACED_QUEUE}" \
  "serviceBusConnectionString=${SERVICE_BUS_CONNECTION_STRING}"
