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

module "observability" {
  source = "../modules/observability"
  prefix   = var.prefix
  location = var.location
}

module "storage_account" {
  source = "../modules/storage_account"

  prefix   = var.prefix
  location = var.location
}

module "faas_eh_sa" {
  source = "../modules/faas_eh_sa"

  prefix   = var.prefix
  location = var.location
}

module "vm_psql_net" {
  source = "../modules/vm_psql"

  prefix   = var.prefix
  location = var.location

  psql_admin        = var.psql_admin
  psql_password     = var.psql_password
  psql_storage_size = var.psql_storage_size
  psql_sku          = var.psql_sku

  vm_size           = var.vm_size
  ssh_pub_key_path  = var.ssh_pub_key_path

  log_analytics_workspace_id = module.observability.log_analytics_workspace_id
}
