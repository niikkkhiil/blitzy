locals {
  name_prefix = var.prefix
  aks_name = "${local.name_prefix}-aks"
  acr_name = lower(replace("${local.name_prefix}acr", "/[^a-z0-9]/", ""))
  postgres_name = "${local.name_prefix}-pg"
  redis_name = "${local.name_prefix}-redis"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
  tags = var.tags
}

# Networking Module
module "networking" {
  source = "./modules/networking"
  
  name_prefix = local.name_prefix
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  vnet_cidr = var.vnet_cidr
  k8s_subnet_cidr = var.k8s_subnet_cidr
  db_subnet_cidr = var.db_subnet_cidr
  redis_subnet_cidr = var.redis_subnet_cidr
  shared_subnet_cidr = var.shared_subnet_cidr
  tags = var.tags
}

# ACR Module
module "acr" {
  source = "./modules/acr"
  
  registry_name = local.acr_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku = var.acr_sku
  tags = var.tags
}

# AKS Module
module "aks" {
  source = "./modules/aks"
  
  cluster_name = local.aks_name
  name_prefix = local.name_prefix
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id = module.networking.k8s_subnet_id
  kubernetes_version = var.kubernetes_version
  node_count = var.aks_node_count
  min_count = var.aks_min_count
  max_count = var.aks_max_count
  vm_size = var.aks_vm_size
  service_cidr = var.aks_service_cidr
  dns_service_ip = var.aks_dns_service_ip
  acr_id = module.acr.registry_id
  tags = var.tags
}

# PostgreSQL Module
module "postgresql" {
  source = "./modules/postgresql"
  
  server_name = local.postgres_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id = module.networking.db_subnet_id
  vnet_id = module.networking.vnet_id
  postgres_version = var.postgres_version
  admin_username = var.postgres_admin_username
  admin_password = var.postgres_admin_password
  storage_mb = var.postgres_storage_mb
  sku_name = var.postgres_sku_name
  tags = var.tags
}

# Redis Module
module "redis" {
  source = "./modules/redis"
  
  cache_name = local.redis_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id = module.networking.redis_subnet_id
  capacity = var.redis_capacity
  family = var.redis_family
  sku_name = var.redis_sku_name
  private_ip = var.redis_private_ip
  tags = var.tags
}