terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "azure4devopscs"
    storage_account_name = "cs4cr"
    container_name       = "azurecs4container"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
  subscription_id = "426b8104-3a89-42f0-a3f5-14b554b1b2bb"
  client_id       = "97945ed2-39bb-467f-a3bd-5a518ae08fd6"
  tenant_id       = "09201aea-fd49-442b-9a0d-8de2389cefaf"
  client_secret   = "Eq18Q~aNNSuiTc2jwoCXGB8Ka4xWHLPqi4O9ycBQ"

}


data "azurerm_resource_group" "rg" {
  name = "azcs4"
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
