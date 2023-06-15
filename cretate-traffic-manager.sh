#!/bin/sh

az network traffic-manager profile create \
	--name ${TRAFFIC_MANAGER_PROFILE} \
	--resource-group ${RESOURCE_GROUP} \
	--routing-method Priority \
	--path '/' \
	--protocol "HTTP" \
	--unique-dns-name ${TRAFFIC_MANAGER_PROFILE}  \
	--ttl 30 \
  --port 80

APP_1_RESOURCE_ID=$(az webapp show --name ${WEP_APP_SUBDOMAIN} --resource-group ${RESOURCE_GROUP} --query id --output tsv)
APP_2_RESOURCE_ID=$(az webapp show --name ${WEP_APP_SUBDOMAIN_2} --resource-group ${RESOURCE_GROUP} --query id --output tsv)

az network traffic-manager endpoint create \
  --name ${WEP_APP_SUBDOMAIN} \
  --resource-group ${RESOURCE_GROUP} \
  --profile-name ${TRAFFIC_MANAGER_PROFILE} \
  --type azureEndpoints \
  --target-resource-id ${APP_1_RESOURCE_ID} \
  --priority 1 \
  --endpoint-status Enabled

az network traffic-manager endpoint create \
  --name ${WEP_APP_SUBDOMAIN_2} \
  --resource-group ${RESOURCE_GROUP} \
  --profile-name ${TRAFFIC_MANAGER_PROFILE} \
  --type azureEndpoints \
  --target-resource-id ${APP_2_RESOURCE_ID} \
  --priority 2 \
  --endpoint-status Enabled

