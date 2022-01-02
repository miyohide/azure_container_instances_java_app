#!/bin/bash

RESOURCE_GROUP_NAME=tfstate
STORAGE_ACCOUNT_NAME=tfstate$RANDOM
CONTAINER_NAME_01_PREPARE=tfstate01prepare
CONTAINER_NAME_02_EXEC=tfstate02exec

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME_01_PREPARE --account-name $STORAGE_ACCOUNT_NAME
az storage container create --name $CONTAINER_NAME_02_EXEC --account-name $STORAGE_ACCOUNT_NAME
