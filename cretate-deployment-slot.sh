#!/bin/sh

az webapp deployment slot create \
    --name ${WEP_APP_SUBDOMAIN} \
    --resource-group ${RESOURCE_GROUP} \
    --slot ${DEPLOYMENT_SLOT}
