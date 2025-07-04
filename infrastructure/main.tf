terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-lab9-demo"
  location = "East US"

  tags = {
    Environment = "Lab9"
    Project     = "DevOps"
  }
}

# Create a storage account
resource "azurerm_storage_account" "storage" {
  name                     = "stlab9demo${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = "Lab9"
    Project     = "DevOps"
  }
}

# Create a random string for unique naming
resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

# Output the storage account name
output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

# Output the resource group name
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
} 