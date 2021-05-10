terraform {
  required_version = "0.14.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.57.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

module "faas" {
  source = "../modules/faas_eh_sa"

  prefix   = var.prefix
  location = var.location
}