variable "name_prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_cidr" {
  type = string
}

variable "k8s_subnet_cidr" {
  type = string
}

variable "db_subnet_cidr" {
  type = string
}

variable "redis_subnet_cidr" {
  type = string
}

variable "shared_subnet_cidr" {
  type = string
}

variable "tags" {
  type = map(string)
}