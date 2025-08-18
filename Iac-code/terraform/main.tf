terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "azcs4"
    storage_account_name = "azcs4"
    container_name       = "azcs4container"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
  subscription_id = "426b8104-3a89-42f0-a3f5-14b554b1b2bb"
  client_id       = "bf5e8e4f-3aea-40f9-bba6-0978ac70f104"
  tenant_id       = "09201aea-fd49-442b-9a0d-8de2389cefaf"
  client_secret   = "WtL8Q~2F1jhXJug7.42TcMEJInkXHZqhYZTfEdoR"

}


data "azurerm_resource_group" "rg" {
  name = "azcs4"
  location = "East US"  
}


resource "azurerm_service_plan" "plan" {
  name                = "${var.planname}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku_name            = "F1"  
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "app" {
  name                = "${var.appname}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.plan.id


  site_config {
    always_on = true
  }
}
