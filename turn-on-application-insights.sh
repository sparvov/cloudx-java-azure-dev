#!/bin/sh

az monitor app-insights component create --app ${WEP_APP_SUBDOMAIN} -g ${RESOURCE_GROUP} --location eastus
az webapp config appsettings set --name ${WEP_APP_SUBDOMAIN} --resource-group ${RESOURCE_GROUP} --settings \
  "APPINSIGHTS_INSTRUMENTATIONKEY=$(az monitor app-insights component show --app ${WEP_APP_SUBDOMAIN} --resource-group ${RESOURCE_GROUP} --query instrumentationKey --output tsv)" \
  "APPLICATIONINSIGHTS_CONNECTION_STRING=$(az monitor app-insights component show --app ${WEP_APP_SUBDOMAIN} --resource-group ${RESOURCE_GROUP} --query connectionString --output tsv)" \
  "ApplicationInsightsAgent_EXTENSION_VERSION=~3"

az monitor app-insights component create -a ${WEP_APP_SUBDOMAIN_2} -g ${RESOURCE_GROUP} -l eastus
az webapp config appsettings set -n ${WEP_APP_SUBDOMAIN_2} -g ${RESOURCE_GROUP} --settings \
  "APPINSIGHTS_INSTRUMENTATIONKEY=$(az monitor app-insights component show -a ${WEP_APP_SUBDOMAIN_2} -g ${RESOURCE_GROUP} --query instrumentationKey -o tsv)" \
  "APPLICATIONINSIGHTS_CONNECTION_STRING=$(az monitor app-insights component show -a ${WEP_APP_SUBDOMAIN_2} -g ${RESOURCE_GROUP} --query connectionString -o tsv)" \
  "ApplicationInsightsAgent_EXTENSION_VERSION=~3"

az monitor app-insights component create -a ${PRODUCT_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} -l eastus
az webapp config appsettings set -n ${PRODUCT_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} --settings \
  "APPINSIGHTS_INSTRUMENTATIONKEY=$(az monitor app-insights component show -a ${PRODUCT_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} --query instrumentationKey -o tsv)" \
  "APPLICATIONINSIGHTS_CONNECTION_STRING=$(az monitor app-insights component show -a ${PRODUCT_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} --query connectionString -o tsv)" \
  "ApplicationInsightsAgent_EXTENSION_VERSION=~3"

az monitor app-insights component create -a ${PET_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} -l eastus
az webapp config appsettings set -n ${PET_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} --settings \
  "APPINSIGHTS_INSTRUMENTATIONKEY=$(az monitor app-insights component show -a ${PET_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} --query instrumentationKey -o tsv)" \
  "APPLICATIONINSIGHTS_CONNECTION_STRING=$(az monitor app-insights component show -a ${PET_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} --query connectionString -o tsv)" \
  "ApplicationInsightsAgent_EXTENSION_VERSION=~3"

az monitor app-insights component create -a ${ORDER_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} -l eastus
az webapp config appsettings set -n ${ORDER_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} --settings \
  "APPINSIGHTS_INSTRUMENTATIONKEY=$(az monitor app-insights component show -a ${ORDER_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} --query instrumentationKey -o tsv)" \
  "APPLICATIONINSIGHTS_CONNECTION_STRING=$(az monitor app-insights component show -a ${ORDER_SERVICE_SUBDOMAIN} -g ${RESOURCE_GROUP} --query connectionString -o tsv)" \
  "ApplicationInsightsAgent_EXTENSION_VERSION=~3"
