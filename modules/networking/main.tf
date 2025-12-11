# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name = "${var.name_prefix}-vnet"
  address_space = [var.vnet_cidr]
  location = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
}

# Subnets
resource "azurerm_subnet" "k8s_subnet" {
  name = "${var.name_prefix}-k8s-subnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [var.k8s_subnet_cidr]
  delegation {
    name = "aks_delegation"
    service_delegation {
      name = "Microsoft.ContainerService/managedClusters"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "db" {
  name = "${var.name_prefix}-db-subnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [var.db_subnet_cidr]
}

resource "azurerm_subnet" "redis" {
  name = "${var.name_prefix}-redis-subnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [var.redis_subnet_cidr]
}

resource "azurerm_subnet" "shared" {
  name = "${var.name_prefix}-shared-subnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [var.shared_subnet_cidr]
}

# NAT Gateway
resource "azurerm_public_ip" "nat_ip" {
  name = "${var.name_prefix}-nat-pip"
  location = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_nat_gateway" "nat" {
  name = "${var.name_prefix}-nat"
  location = var.location
  resource_group_name = var.resource_group_name
  sku_name = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "nat_ip_assoc" {
  nat_gateway_id = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.nat_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "k8s_nat_assoc" {
  subnet_id = azurerm_subnet.k8s_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}

# Network Security Groups
resource "azurerm_network_security_group" "k8s_nsg" {
  name = "${var.name_prefix}-k8s-nsg"
  location = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
}

resource "azurerm_network_security_group" "db_nsg" {
  name = "${var.name_prefix}-db-nsg"
  location = var.location
  resource_group_name = var.resource_group_name
  
  security_rule {
    name = "AllowPostgreSQL"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "5432"
    source_address_prefix = var.k8s_subnet_cidr
    destination_address_prefix = "*"
  }
  tags = var.tags
}

resource "azurerm_network_security_group" "redis_nsg" {
  name = "${var.name_prefix}-redis-nsg"
  location = var.location
  resource_group_name = var.resource_group_name
  
  security_rule {
    name = "AllowRedis"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "6380"
    source_address_prefix = var.k8s_subnet_cidr
    destination_address_prefix = "*"
  }
  tags = var.tags
}

resource "azurerm_network_security_group" "shared_nsg" {
  name = "${var.name_prefix}-shared-nsg"
  location = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
}

# NSG Associations
resource "azurerm_subnet_network_security_group_association" "k8s_nsg_assoc" {
  subnet_id = azurerm_subnet.k8s_subnet.id
  network_security_group_id = azurerm_network_security_group.k8s_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "db_nsg_assoc" {
  subnet_id = azurerm_subnet.db.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "redis_nsg_assoc" {
  subnet_id = azurerm_subnet.redis.id
  network_security_group_id = azurerm_network_security_group.redis_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "shared_nsg_assoc" {
  subnet_id = azurerm_subnet.shared.id
  network_security_group_id = azurerm_network_security_group.shared_nsg.id
}