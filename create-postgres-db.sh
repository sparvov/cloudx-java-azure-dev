#!/bin/sh

source ./env.sh

az extension add --name serviceconnector-passwordless --upgrade

az postgres server create \
      --name ${DB_SERVER_NAME} \
      --resource-group ${RESOURCE_GROUP} \
      --location ${LOCATION} \
      --sku-name B_Gen5_1 \
      --admin-user ${DB_ADMIN_USER} \
      --admin-password ${DB_ADMIN_PASSWORD}

az postgres server firewall-rule create \
      --name AllowIP \
      --resource-group ${RESOURCE_GROUP} \
      --server ${DB_SERVER_NAME} \
      --start-ip-address ${MY_IP_ADDRESS} \
      --end-ip-address ${MY_IP_ADDRESS}

az postgres server firewall-rule create \
      --name AllowAllWindowsAzureIps \
      --resource-group ${RESOURCE_GROUP} \
      --server ${DB_SERVER_NAME} \
      --start-ip-address 0.0.0.0 \
      --end-ip-address 0.0.0.0

az postgres db create \
    --name ${DB_NAME} \
    --resource-group ${RESOURCE_GROUP} \
    --server-name ${DB_SERVER_NAME}
