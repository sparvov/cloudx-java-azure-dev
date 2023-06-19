#!/bin/sh

az servicebus namespace create \
    --name ${NAMESPACE} \
    --resource-group ${RESOURCE_GROUP} \
    --location ${LOCATION} \
    --sku Standard

az servicebus queue create \
    --name ${ORDER_PLACED_QUEUE} \
    --max-delivery-count 3 \
    --namespace-name ${NAMESPACE} \
    --resource-group ${RESOURCE_GROUP}
