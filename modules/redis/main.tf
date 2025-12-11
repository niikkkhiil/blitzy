resource "azurerm_redis_cache" "redis" {
  name = var.cache_name
  location = var.location
  resource_group_name = var.resource_group_name
  capacity = var.capacity
  family = var.family
  sku_name = var.sku_name
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  subnet_id = var.subnet_id
  private_static_ip_address = var.private_ip
  
  redis_configuration {
    enable_authentication = true
  }
  
  tags = var.tags
}