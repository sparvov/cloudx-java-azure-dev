#!/bin/sh

echo "------------ Create ${WEP_APP_NAME} for ${LOCATION}"
cd ./petstore/petstoreapp
az acr build --registry "${CONTAINER_REGISTRY}.azurecr.io" --image ${WEB_APP_IMAGE} .
az appservice plan create --name ${WEB_APP_SERVICE_PLAN} --resource-group ${RESOURCE_GROUP} --sku ${SERVICE_PLAN_WEB_APP_SKU} --is-linux -l ${LOCATION}
az webapp create -n ${WEP_APP_SUBDOMAIN} -g ${RESOURCE_GROUP} -p "${WEB_APP_SERVICE_PLAN}" -i "${CONTAINER_REGISTRY}.azurecr.io/${WEB_APP_IMAGE}"
az webapp deployment container config --enable-cd true -g ${RESOURCE_GROUP} -n ${WEP_APP_SUBDOMAIN}
az webapp config appsettings set -g ${RESOURCE_GROUP} -n ${WEP_APP_SUBDOMAIN} --settings \
    PETSTOREPETSERVICE_URL="https://${PET_SERVICE_SUBDOMAIN}.azurewebsites.net" \
    PETSTOREPRODUCTSERVICE_URL="https://${PRODUCT_SERVICE_SUBDOMAIN}.azurewebsites.net" \
    PETSTOREORDERSERVICE_URL="https://${ORDER_SERVICE_SUBDOMAIN}.azurewebsites.net"
