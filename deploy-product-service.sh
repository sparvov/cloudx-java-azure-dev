#!/bin/sh

echo "------------ Create ${PRODUCT_SERVICE_NAME}"
cd ./petstore/petstoreproductservice
az acr build --registry "${CONTAINER_REGISTRY}.azurecr.io" --image ${PRODUCT_SERVICE_IMAGE} .
az appservice plan create --name ${PRODUCT_SERVICE_SERVICE_PLAN} --resource-group ${RESOURCE_GROUP} --sku ${SERVICE_PLAN_SKU} --is-linux -l ${LOCATION}
az webapp create -n ${PRODUCT_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} -p "${PRODUCT_SERVICE_SERVICE_PLAN}" -i "${CONTAINER_REGISTRY}.azurecr.io/${PRODUCT_SERVICE_IMAGE}"
az webapp deployment container config --enable-cd true -g ${RESOURCE_GROUP} -n ${PRODUCT_SERVICE_SUBDOMAIN}
