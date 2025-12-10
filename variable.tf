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

