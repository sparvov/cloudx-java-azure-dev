#!/bin/bash

az login

target_subscription_name="Visual Studio Professional Subscription"

target_subscription_id=$(az account list --query "[?name=='$target_subscription_name'].id" --output tsv)

az account set --subscription $target_subscription_id
