#!/bin/sh

source ./env.sh

echo "------------ Login"
./login-to-azure.sh

echo "------------ Create Resource Group & Container Registry"
az group create --name ${RESOURCE_GROUP} --location ${LOCATION}
az acr create --name ${CONTAINER_REGISTRY} --resource-group ${RESOURCE_GROUP} --sku Basic --admin-enabled true

echo "------------ Create Key Vault"
./create-keyvault.sh

echo "------------ Create PostgreSQL DB"
./create-postgres-db.sh

echo "------------ Create Cosmos DB"
./create-cosmos-db.sh

echo "------------ Create & deploy services"
./deploy-webapp-service.sh
./deploy-webapp-service-2.sh
./deploy-pet-service.sh
./deploy-product-service.sh
./deploy-order-service.sh

echo "------------ Set services permission to Keyvault"
./set-keyvault-permission-all.sh

echo "------------ Turn on Application Insights"
./turn-on-application-insights.sh

echo "------------ Create Traffic Manager"
./cretate-traffic-manager.sh

echo "------------ Create Autoscaling"
./cretate-autoscalings-all.sh

echo "------------ Create Deployment Slot"
./cretate-deployment-slot.sh
