/*
==============================
Azure Resource Group Variables
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
==============================
*/
variable "resource_group_name" {
  default     = "aks-ondat-demo"
  type        = string
  sensitive   = false
  description = "The resource group name where resources will be provisioned."

}

variable "resource_group_location" {
  default     = "North Europe"
  type        = string
  sensitive   = false
  description = "The Azure region where resources will be provisioned."
}

variable "resource_group_tags" {
  default     = { environment = "ondat-demo" }
  type        = map(string)
  sensitive   = false
  description = "The key-value tag(s) that will be set for the Resource Group."
}

/*
=======================
Azure Monitor Variables
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution
=======================
*/
variable "log_analytics_workspace_name" {
  default     = "aks-ondat-monitoring"
  type        = string
  sensitive   = false
  description = "The name to be used to provision Log Analytics workspace resources."
}

variable "log_analytics_workspace_pricing_tier" {
  default     = "PerGB2018"
  type        = string
  sensitive   = false
  description = "The sku/pricing tier to be used to provision Log Analytics workspace resources."
}

variable "log_analytics_workspace_retention" {
  default     = 30
  type        = number
  sensitive   = false
  description = "The Log Analytics workspace data retention in days."
}

variable "log_analytics_workspace_daily_quota" {
  default     = 0.5
  type        = number
  sensitive   = false
  description = "The Log Analytics workspace daily quota for ingestion in GB."
}

variable "azurerm_monitor_diagnostics_name" {
  default     = "PerGB2018"
  type        = string
  sensitive   = false
  description = "The name of the diagnostic setting to be provisioned."
}

/*
==========================================
Managed Azure Kubernetes Service Variables
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
==========================================
*/
variable "cluster_name" {
  default     = "ondat-cluster"
  type        = string
  sensitive   = false
  description = "The name of the AKS cluster to be created."
}

variable "cluster_auto_upgrade" {
  default     = "stable"
  type        = string
  sensitive   = false
  description = "The upgrade channel for the AKS Cluster."
}

variable "cluster_kubernetes_version" {
  default     = "1.23.5"
  type        = string
  sensitive   = false
  description = "The Kubernetes version for the AKS Cluster."
}

variable "cluster_pricing_tier" {
  default     = "Free"
  type        = string
  sensitive   = false
  description = "The sku/pricing tier to be used to provision resources."
}

variable "idenity_profile_type" {
  default     = "SystemAssigned"
  type        = string
  sensitive   = false
  description = "The type of identity used for the AKS cluster."
}

variable "network_profile_plugin" {
  default     = "kubenet"
  type        = string
  sensitive   = false
  description = "The network plugin to use for networking in the AKS cluster."
}

variable "network_profile_mode" {
  default     = "transparent"
  type        = string
  sensitive   = false
  description = "The network plugin to use with Azure CNI in the AKS cluster."
}

variable "network_profile_policy" {
  default     = "calico"
  type        = string
  sensitive   = false
  description = "The network policy to use with Azure CNI in the AKS cluster."
}

variable "linux_profile_username" {
  default     = "ubuntu"
  type        = string
  sensitive   = false
  description = "The admin username for the AKS cluster."
}

variable "linux_profile_public_ssh_key" {
  default     = "~/.ssh/id_rsa_aks.pub"
  type        = string
  sensitive   = true
  description = "The path at which your ssh key for the AKS cluster is located."
}

variable "default_node_pool_name" {
  default     = "default"
  type        = string
  sensitive   = false
  description = "The name which should be used for the default AKS cluster node pool."
}

variable "default_node_pool_vm_size" {
  default     = "Standard_DS2_v2"
  type        = string
  sensitive   = false
  description = "The size of the virtual machine to be used in the default AKS cluster node pool."
}

variable "default_node_pool_availability_zones" {
  default     = ["1", "2", "3"]
  type        = list(string)
  sensitive   = false
  description = "A list of Availability Zones across which the node pool should be spread in the default AKS cluster node pool."
}

variable "default_node_pool_vm_type" {
  default     = "VirtualMachineScaleSets"
  type        = string
  sensitive   = false
  description = "The type of node pool which should be created in the default AKS cluster node pool."
}

variable "default_node_pool_kubelet_disk_type" {
  default     = "OS"
  type        = string
  sensitive   = false
  description = " The type of disk used by kubelet in the default AKS cluster node pool."
}

variable "default_node_pool_node_labels" {
  default     = { "storageos.com/computeonly" = "true" }
  type        = map(string)
  sensitive   = false
  description = "Kubernetes labels which will be applied to nodes in the default AKS cluster node pool."
}

variable "default_node_pool_os_disk_type" {
  default     = "Managed"
  type        = string
  sensitive   = false
  description = "The type of disk which should be used for the node operating system in the default AKS cluster node pool."
}

variable "default_node_pool_os_disk_size_gb" {
  default     = 512
  type        = number
  sensitive   = false
  description = "The disk size for the node operating system which should be used in the default AKS cluster node pool."
}

variable "default_node_pool_os_type" {
  default     = "Ubuntu"
  type        = string
  sensitive   = false
  description = "The type of Linux operating system which should be used for the nodes in the default AKS cluster node pool."
}

variable "default_node_pool_node_count" {
  default     = 3
  type        = number
  sensitive   = false
  description = "The number of nodes which provisioned in the default AKS cluster node pool."
}


/*
============================================
Azure Kubernetes Service Node Pool Variables
============================================
*/
variable "node_pool_1" {
  default     = "storage"
  type        = string
  sensitive   = false
  description = "The name which should be used for node_pool_1."
}

variable "node_pool_1_vm_size" {
  default     = "Standard_DS2_v2"
  type        = string
  sensitive   = false
  description = "The size of the virtual machine to be used in thenode_pool_1."
}

variable "node_pool_1_availability_zones" {
  default     = ["1", "2", "3"]
  type        = list(string)
  sensitive   = false
  description = "A list of Availability Zones across which the node pool should be spread in node_pool_1."
}

variable "node_pool_1_os_disk_size_gb" {
  default     = 1024
  type        = number
  sensitive   = false
  description = "The disk size for the node operating system which should be used in the node_pool_1."
}

variable "node_pool_1_node_count" {
  default     = 2
  type        = number
  sensitive   = false
  description = "The number of nodes which provisioned in the node_pool_1."
}

/*
====================
Local File Variables
====================
*/
variable "kubeconfig_filename" {
  default     = "kubeconfig"
  type        = string
  sensitive   = false
  description = "The path and name of the kubeconfig to create."
}

/*
===============
Ondat Variables
===============
*/

variable "ondat_admin_username" {
  default     = "storageos"
  type        = string
  sensitive   = false
  description = "The admin username for Ondat."
}

variable "ondat_admin_password" {
  default     = "storageos"
  type        = string
  sensitive   = false
  description = "The admin password for Ondat."
}

variable "ondat_namespace" {
  default     = "storageos"
  type        = string
  sensitive   = false
  description = "The namespace where Ondat components will be deployed."
}

variable "ondat_etcd_namespace" {
  default     = "storageos-etcd"
  type        = string
  sensitive   = false
  description = "The namespace where Ondat's etcd will be deployed."
}

variable "ondat_etcd_storage_class" {
  default     = "default"
  type        = string
  sensitive   = false
  description = "The storage class type that Ondat's etcd will use."
}

variable "ondat_version" {
  default     = "v2.7.0"
  type        = string
  sensitive   = false
  description = "The Ondat version that will be deployed."
}
