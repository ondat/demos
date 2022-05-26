/*
==================================
Azure Resource Group Return Values
==================================
*/
output "resource_group_id" {
  value       = data.azurerm_resource_group.rg.name
  sensitive   = false
  description = "The ID of the resource group."
}

output "resource_group_region" {
  value       = data.azurerm_resource_group.rg.location
  sensitive   = false
  description = "The region where the resource group exists."
}

output "resource_group_tags" {
  value       = data.azurerm_resource_group.rg.tags
  sensitive   = false
  description = "The tags assigned to this resource group exists."
}

/*
===========================
Azure Monitor Return Values
===========================
*/
output "log_analytics_workspace_id" {
  value       = data.azurerm_log_analytics_workspace.monitor.workspace_id
  sensitive   = false
  description = "The ID of the Log Analytics workspace."
}

output "log_analytics_workspace_pricing_tier" {
  value       = data.azurerm_log_analytics_workspace.monitor.sku
  sensitive   = false
  description = "The sku/pricing tier of the Log Analytics workspace."
}

output "log_analytics_workspace_retention" {
  value       = data.azurerm_log_analytics_workspace.monitor.retention_in_days
  sensitive   = false
  description = "The Log Analytics workspace data retention in days."
}

output "log_analytics_workspace_daily_quota" {
  value       = data.azurerm_log_analytics_workspace.monitor.daily_quota_gb
  sensitive   = false
  description = "The Log Analytics workspace daily quota for ingestion in GB."
}

output "log_analytics_workspace_tags" {
  value       = data.azurerm_log_analytics_workspace.monitor.tags
  sensitive   = false
  description = "The key-value tag(s) that will set for the Log Analytics workspace."
}

/*
==============================================
Managed Azure Kubernetes Service Return Values
==============================================
*/
output "aks_cluster_id" {
  value       = data.azurerm_kubernetes_cluster.cluster.id
  sensitive   = false
  description = "The ID of the AKS cluster."
}

output "aks_cluster_name" {
  value       = data.azurerm_kubernetes_cluster.cluster.name
  sensitive   = false
  description = "The name of the AKS cluster."
}

output "aks_cluster_dns_prefix" {
  value       = data.azurerm_kubernetes_cluster.cluster.dns_prefix
  sensitive   = false
  description = "The DNS Prefix of the AKS cluster."
}

output "aks_cluster_kubernetes_version" {
  value       = data.azurerm_kubernetes_cluster.cluster.kubernetes_version
  sensitive   = false
  description = "The Kubernetes version of the AKS cluster."
}

output "aks_cluster_region" {
  value       = data.azurerm_kubernetes_cluster.cluster.location
  sensitive   = false
  description = "The region in which the version of the AKS cluster exists."
}

output "aks_cluster_tags" {
  value       = data.azurerm_kubernetes_cluster.cluster.tags
  sensitive   = false
  description = "The tags mapped to the AKS cluster."
}

output "aks_cluster_identity" {
  value       = data.azurerm_kubernetes_cluster.cluster.identity
  sensitive   = false
  description = "The type of identity used for the AKS cluster."
}

output "aks_cluster_linux_profile" {
  value       = data.azurerm_kubernetes_cluster.cluster.linux_profile
  sensitive   = false
  description = "The Linux profile details for the AKS cluster."
}

output "aks_cluster_network_profile" {
  value       = data.azurerm_kubernetes_cluster.cluster.network_profile
  sensitive   = false
  description = "The network profile details used for the AKS cluster."
}

output "aks_cluster_role_based_access_control" {
  value       = data.azurerm_kubernetes_cluster.cluster.role_based_access_control
  sensitive   = false
  description = "The RBAC details used for the AKS cluster."
}

output "aks_cluster_addon_profile" {
  value       = data.azurerm_kubernetes_cluster.cluster.addon_profile
  sensitive   = false
  description = "The add-on profile details used for the AKS cluster."
}

output "aks_cluster_agent_pool_profile" {
  value       = data.azurerm_kubernetes_cluster.cluster.agent_pool_profile
  sensitive   = false
  description = "The agent pool profile details used for the AKS cluster."
}

/*
================================================
Azure Kubernetes Service Node Pool Return Values
================================================
*/
output "node_pool_id" {
  value       = data.azurerm_kubernetes_cluster_node_pool.storage.id
  sensitive   = false
  description = "The ID of the node pool."
}

output "node_pool_availability_zones" {
  value       = data.azurerm_kubernetes_cluster_node_pool.storage.availability_zones
  sensitive   = false
  description = "The availability zones in which nodes of the node pool exist."
}

output "node_pool_enable_auto_scaling" {
  value       = data.azurerm_kubernetes_cluster_node_pool.storage.enable_auto_scaling
  sensitive   = false
  description = "Is auto-scaling enabled for the node pool?"
}

output "node_pool_enable_node_public_ip" {
  value       = data.azurerm_kubernetes_cluster_node_pool.storage.enable_node_public_ip
  sensitive   = false
  description = "Do the nodes have public IP addresses enabled for the node pool?"
}

output "node_pool_enable_node_count" {
  value       = data.azurerm_kubernetes_cluster_node_pool.storage.node_count
  sensitive   = false
  description = "The number of nodes in the node pool?"
}

output "node_pool_enable_orchestrator_version" {
  value       = data.azurerm_kubernetes_cluster_node_pool.storage.orchestrator_version
  sensitive   = false
  description = "The Kubernetes version configured on each node in the node pool?"
}

output "node_pool_enable_os_disk_size_gb" {
  value       = data.azurerm_kubernetes_cluster_node_pool.storage.os_disk_size_gb
  sensitive   = false
  description = "The size of the OS disk on each node in the node pool?"
}

output "node_pool_enable_vm_size" {
  value       = data.azurerm_kubernetes_cluster_node_pool.storage.vm_size
  sensitive   = false
  description = "The size of the virtual machine on each node in the node pool?"
}

/*
===================
Ondat Return Values
===================
*/
output "ondat_admin_username" {
  value       = var.ondat_admin_username
  sensitive   = false
  description = "The admin username for Ondat."
}

output "ondat_admin_password" {
  value       = var.ondat_admin_password
  sensitive   = false
  description = "The admin password for Ondat."
}

output "ondat_namespace" {
  value       = var.ondat_namespace
  sensitive   = false
  description = "The namespace where Ondat components are deployed."
}

output "ondat_etcd_namespace" {
  value       = var.ondat_etcd_namespace
  sensitive   = false
  description = "The namespace where Ondat's etcd is deployed."
}

output "ondat_etcd_storage_class" {
  value       = var.ondat_etcd_storage_class
  sensitive   = false
  description = "The storage class type that Ondat's etcd used."
}

output "ondat_version" {
  value       = var.ondat_version
  sensitive   = false
  description = "The Ondat version deployed."
}