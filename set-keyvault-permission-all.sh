#!/bin/sh

./set-keyvault-permission.sh ${PRODUCT_SERVICE_SUBDOMAIN}
./set-keyvault-permission.sh ${PET_SERVICE_SUBDOMAIN}
./set-keyvault-permission.sh ${ORDER_SERVICE_SUBDOMAIN}
