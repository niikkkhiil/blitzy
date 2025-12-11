output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "k8s_subnet_id" {
  value = azurerm_subnet.k8s_subnet.id
}

output "db_subnet_id" {
  value = azurerm_subnet.db.id
}

output "redis_subnet_id" {
  value = azurerm_subnet.redis.id
}

output "shared_subnet_id" {
  value = azurerm_subnet.shared.id
}