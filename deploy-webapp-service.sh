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
    PETSTOREORDERSERVICE_URL="https://${ORDER_SERVICE_SUBDOMAIN}.azurewebsites.net" \
    AUTHORIZATION_SERVER_BASE_URI="https://petstoreonline.b2clogin.com/petstoreonline.onmicrosoft.com/" \
    AZURE_CLIENT_ID="3053c3be-0471-44f5-903a-42f973883db3" \
    AZURE_CLIENT_SECRET="Mwp8Q~H786DFXQ6rM5PaowEtVmExIonaLVal~cD-" \
    LOGIN_USER_FLOW_KEY="sign-up-or-sign-in" \
    LOGOUT_SUCCESS_URL="https://${WEP_APP_SUBDOMAIN_EASTUS}.azurewebsites.net/login" \
    SIGN_UP_OR_SIGN_IN_FLOW_NAME="B2C_1_signupsignin"

#az webapp log tail --name ${WEP_APP_SUBDOMAIN_EASTUS} --resource-group ${RESOURCE_GROUP}
