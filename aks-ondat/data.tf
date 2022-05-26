/*
============
Data Sources
============
*/
data "azurerm_resource_group" "rg" {
  depends_on = [azurerm_resource_group.rg]

  name = "${var.resource_group_name}-resources"
}

data "azurerm_log_analytics_workspace" "monitor" {
  depends_on = [azurerm_log_analytics_workspace.monitor]

  name                = "${var.log_analytics_workspace_name}-${random_id.workspace.dec}"
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_kubernetes_cluster" "cluster" {
  depends_on = [azurerm_kubernetes_cluster.cluster]

  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_kubernetes_cluster_node_pool" "storage" {
  depends_on = [azurerm_kubernetes_cluster_node_pool.storage]

  name                    = var.node_pool_1
  kubernetes_cluster_name = var.cluster_name
  resource_group_name     = azurerm_resource_group.rg.name
}
