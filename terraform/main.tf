terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.0
    }
  }
}

data "azurerm_client_config" "current" {}
resource "azurerm_role_assignment" "reader" {}
provider "azurerm" {}


provider "azuread" {
  tenant_id = data.azurerm_client_config.current.tenant_id
}



#variable "tenant_id" {}

resource "azuread_application" "app" {
  display_name = "app-theatester"
}

resource "azuread_service_principal" "sp" {
  client_id = azuread_application.app.client_id
}

resource "azuread_application_password" "secret" {
  application_id = azuread_application.app.id
  display_name   = "terraform-secret"
}

output "client_id" {
  value = azuread_application.app.client_id
}

output "tenant_id" {
  value = data.azurerm_client_config.tenant_id
}

output "client_secret" {
  value     = azuread_application_password.secret.value
  sensitive = true
}

provider "azurerm" {
  features {}
  subscription_id = data.azurerm_client_config.current.subscription_id
}

#variable "subscription_id" {}

resource "azurerm_role_assignment" "reader" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.sp.object_id
}