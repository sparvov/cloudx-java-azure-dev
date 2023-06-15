#!/bin/bash

service_plan=$1
autoscale=$2

az monitor autoscale create \
    --resource-group ${RESOURCE_GROUP} \
    --resource ${service_plan} \
    --resource-type Microsoft.Web/serverfarms \
    --name ${autoscale} \
    --min-count 1 \
    --max-count 2 \
    --count 1

az monitor autoscale rule create \
    --resource-group ${RESOURCE_GROUP} \
    --autoscale-name ${autoscale} \
    --condition "CpuPercentage > 70 avg 5m" \
    --scale to 2

az monitor autoscale rule create \
    --resource-group ${RESOURCE_GROUP} \
    --autoscale-name ${autoscale} \
    --condition "CpuPercentage > 60 avg 5m" \
    --scale to 1
