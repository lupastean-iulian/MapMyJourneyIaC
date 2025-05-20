terraform {
  backend "azurerm" {
    resource_group_name  = "MapMyJourneyRG"
    storage_account_name = "mapmyjourneytfstate"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "main" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type = "Linux"
  sku_name = "F1"
}

resource "azurerm_static_web_app" "frontend" {
  name                = var.frontend_web_app_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku_tier = "Free"
}

resource "azurerm_linux_web_app" "backend" {
  name                = var.backend_web_app_name
  resource_group_name = azurerm_resource_group.main.name
  location            = "Global"
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    websockets_enabled = true
    application_stack {
      dotnet_version = "8.0"
    }
  }
}

resource "azurerm_mssql_server" "main" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "main" {
  name           = var.sql_database_name
  server_id      = azurerm_mssql_server.main.id
  sku_name       = "GP_S_Gen5_2"
  max_size_gb    = 5
  zone_redundant = true
  collation      = "SQL_Latin1_General_CP1_CI_AS"
}
