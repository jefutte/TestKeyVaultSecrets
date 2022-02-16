terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.50" # betyder man mindst skal bruge version 2.50 eller nyere dog ikke version 3.x.x (ikke opdatere major version)
    }
 }
}

provider "azurerm" {
  features {} # skal være der selvom man ikke benytter features

  subscription_id = var.subscription_id # CIMT-Test-Sandbox
  tenant_id       = var.tenant_id
}

#Pull request
resource "azurerm_resource_group" "ghactions-rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    source      = "Terraform"
    ghaction    = "action_tag"
  }
}

