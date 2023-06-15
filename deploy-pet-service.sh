#!/bin/sh

echo "------------ Create ${PET_SERVICE_NAME}"
cd ./petstore/petstorepetservice
az acr build --registry "${CONTAINER_REGISTRY}.azurecr.io" --image ${PET_SERVICE_IMAGE} .
az appservice plan create --name ${PET_SERVICE_SERVICE_PLAN} --resource-group ${RESOURCE_GROUP} --sku ${SERVICE_PLAN_SKU} --is-linux -l ${LOCATION}
az webapp create -n ${PET_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} -p "${PET_SERVICE_SERVICE_PLAN}" -i "${CONTAINER_REGISTRY}.azurecr.io/${PET_SERVICE_IMAGE}"
az webapp deployment container config --enable-cd true -g ${RESOURCE_GROUP} -n ${PET_SERVICE_SUBDOMAIN}
