output "server_fqdn" {
  value = azurerm_postgresql_flexible_server.postgres.fqdn
}

output "server_id" {
  value = azurerm_postgresql_flexible_server.postgres.id
}