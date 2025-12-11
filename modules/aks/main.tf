resource "azurerm_kubernetes_cluster" "aks" {
  name = var.cluster_name
  location = var.location
  resource_group_name = var.resource_group_name
  dns_prefix = "${var.name_prefix}-aks"
  private_cluster_enabled = true
  kubernetes_version = var.kubernetes_version

  default_node_pool {
    name = "default"
    node_count = var.node_count
    vm_size = var.vm_size
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  workload_identity_enabled = true
  oidc_issuer_enabled = true

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  count = var.acr_id != null ? 1 : 0
  principal_id = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope = var.acr_id
}