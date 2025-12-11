variable "location" {
  type    = string
  default = "Central India"
}

variable "resource_group_name" {
  type    = string
  default = "rg-blitzy-test"
}

variable "prefix" {
  type    = string
  default = "blitzy"
}

variable "vnet_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "k8s_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "tags" {
  type = map(string)
  default = {
    Owner = "blitzy-team"
    Env   = "test"
  }
}

variable "db_subnet_cidr" { 
    type = string
    default = "10.0.2.0/24"
}

variable "redis_subnet_cidr" { 
    type = string
    default = "10.0.3.0/24" 
}

variable "shared_subnet_cidr" {
  type = string 
  default = "10.0.4.0/24" 
}

# AKS Variables
variable "kubernetes_version" {
  type = string
  default = "1.28.3"
}

variable "aks_node_count" {
  type = number
  default = 2
}

variable "aks_min_count" {
  type = number
  default = 1
}

variable "aks_max_count" {
  type = number
  default = 5
}

variable "aks_vm_size" {
  type = string
  default = "Standard_D2s_v3"
}

variable "aks_service_cidr" {
  type = string
  default = "10.1.0.0/16"
}

variable "aks_dns_service_ip" {
  type = string
  default = "10.1.0.10"
}

# ACR Variables
variable "acr_sku" {
  type = string
  default = "Standard"
}

# PostgreSQL Variables
variable "postgres_version" {
  type = string
  default = "13"
}

variable "postgres_admin_username" {
  type = string
  default = "pgadmin"
}

variable "postgres_admin_password" {
  type = string
  sensitive = true
}

variable "postgres_storage_mb" {
  type = number
  default = 32768
}

variable "postgres_sku_name" {
  type = string
  default = "B_Standard_B1ms"
}

# Redis Variables
variable "redis_capacity" {
  type = number
  default = 1
}

variable "redis_family" {
  type = string
  default = "P"
}

variable "redis_sku_name" {
  type = string
  default = "Premium"
}

variable "redis_private_ip" {
  type = string
  default = "10.0.3.10"
}

