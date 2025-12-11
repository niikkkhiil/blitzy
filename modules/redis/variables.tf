variable "cache_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "capacity" {
  type = number
}

variable "family" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "private_ip" {
  type = string
}

variable "tags" {
  type = map(string)
}