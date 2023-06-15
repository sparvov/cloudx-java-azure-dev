#!/bin/sh

source ./env.sh

echo "------------ Login"
./login-to-azure.sh

echo "------------ Create Resource Group"
az group create --name ${RESOURCE_GROUP} --location ${LOCATION}

echo "------------ Create Container Registry"
az acr create --name ${CONTAINER_REGISTRY} --resource-group ${RESOURCE_GROUP} --sku Basic --admin-enabled true

echo "------------ Create services"
./deploy-webapp-service.sh
./deploy-webapp-service-2.sh
./deploy-pet-service.sh
./deploy-product-service.sh
./deploy-order-service.sh

echo "------------ Turn on Application Insights"
./turn-on-application-insights.sh

echo "------------ Create Traffic Manager"
./cretate-traffic-manager.sh
