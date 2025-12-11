output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "aks_cluster_id" {
  value = module.aks.cluster_id
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "postgres_fqdn" {
  value = module.postgresql.server_fqdn
}

output "redis_hostname" {
  value = module.redis.hostname
}

output "redis_primary_access_key" {
  value = module.redis.primary_access_key
  sensitive = true
}