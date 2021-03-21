resource "azurerm_postgresql_server" "public" {
  name                = "${var.prefix}-postgresql-pub"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  administrator_login          = var.psql_admin
  administrator_login_password = var.psql_password
  auto_grow_enabled            = true
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  ssl_enforcement_enabled      = true
  sku_name                     = var.psql_sku
  storage_mb                   = var.psql_storage_size
  version                      = "11"
}

resource "azurerm_postgresql_database" "public_db" {
  name                = "exampledb"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_postgresql_server.public.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "psql_public_fw_rule" {
  name                = "vm-public"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_postgresql_server.public.name
  start_ip_address    = azurerm_public_ip.vm_public_pip.id
  end_ip_address      = azurerm_public_ip.vm_public_pip.id
}
