terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Paritala"
    storage_account_name = "ctl2sa"
    container_name       = "ctl2container"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
  subscription_id = "de108057-2edc-44c6-9cdc-365886498d3e"
  client_id       = "450e193b-0a68-445d-acaa-a9105d57060b"
  tenant_id       = "7c733756-1a90-400f-863b-e0c6877412e8"
  client_secret   = "7b.8Q~8dc-jPvmK4VvjBvbauTGBML9hiRTy_nc_Z"
}


data "azurerm_resource_group" "rg" {
  name = "Paritala"
}


resource "azurerm_service_plan" "plan" {
  name                = "${var.planname}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku_name            = "S1"
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