provider "azurerm" {
  features {}
}

/*
====================
Azure Resource Group
====================
*/
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}-resources"
  location = var.resource_group_location
  tags     = var.resource_group_tags
}

/*
================================
Managed Azure Kubernetes Service
================================
*/
resource "azurerm_kubernetes_cluster" "cluster" {
  name                      = var.cluster_name
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  dns_prefix                = var.cluster_name
  automatic_channel_upgrade = var.cluster_auto_upgrade
  kubernetes_version        = var.cluster_kubernetes_version
  sku_tier                  = var.cluster_pricing_tier
  tags                      = var.resource_group_tags

  default_node_pool {
    name                 = var.default_node_pool_name
    vm_size              = var.default_node_pool_vm_size
    availability_zones   = var.default_node_pool_availability_zones
    type                 = var.default_node_pool_vm_type
    kubelet_disk_type    = var.default_node_pool_kubelet_disk_type
    orchestrator_version = var.cluster_kubernetes_version
    os_disk_type         = var.default_node_pool_os_disk_type
    os_disk_size_gb      = var.default_node_pool_os_disk_size_gb
    os_sku               = var.default_node_pool_os_type
    #node_labels                  = var.default_node_pool_node_labels
    node_count                   = var.default_node_pool_node_count
    min_count                    = null
    max_count                    = null
    enable_auto_scaling          = false
    enable_node_public_ip        = false
    ultra_ssd_enabled            = false
    enable_host_encryption       = false
    only_critical_addons_enabled = false
    fips_enabled                 = false
  }

  #  auto_scaler_profile {   
  #  }

  identity {
    type = var.idenity_profile_type
  }

  network_profile {
    network_plugin = var.network_profile_plugin
    #network_mode   = var.network_profile_mode
    #network_policy = var.network_profile_policy
  }

  role_based_access_control {
    enabled = true
  }

  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = file("${var.linux_profile_public_ssh_key}")
    }
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_keyvault_secrets_provider {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    ingress_application_gateway {
      enabled = false
    }

    kube_dashboard {
      enabled = false
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.monitor.id
    }

    open_service_mesh {
      enabled = false
    }
  }
}

/*
==================================
Azure Kubernetes Service Node Pool
==================================
*/
resource "azurerm_kubernetes_cluster_node_pool" "storage" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
  name                  = var.node_pool_1
  vm_size               = var.node_pool_1_vm_size
  availability_zones    = var.node_pool_1_availability_zones
  kubelet_disk_type     = var.default_node_pool_kubelet_disk_type
  orchestrator_version  = var.cluster_kubernetes_version
  os_disk_type          = var.default_node_pool_os_disk_type
  os_disk_size_gb       = var.node_pool_1_os_disk_size_gb
  os_sku                = var.default_node_pool_os_type
  tags                  = var.resource_group_tags
  #node_labels            = var.default_node_pool_node_labels
  node_count             = var.node_pool_1_node_count
  min_count              = null
  max_count              = null
  enable_auto_scaling    = false
  enable_node_public_ip  = false
  ultra_ssd_enabled      = false
  enable_host_encryption = false
  fips_enabled           = false
}

resource "local_file" "kubeconfig" {
  depends_on = [azurerm_kubernetes_cluster.cluster]

  sensitive_content = azurerm_kubernetes_cluster.cluster.kube_config_raw
  filename          = var.kubeconfig_filename
  file_permission   = "0777"

  /*
  =============
  Install Ondat
  =============
  */
  provisioner "local-exec" {
    command     = <<EOT
      export KUBECONFIG="./${var.kubeconfig_filename}"

      kubectl storageos install \
        --include-etcd \
        --etcd-tls-enabled \
        --etcd-storage-class='${var.ondat_etcd_storage_class}' \
        --etcd-namespace='${var.ondat_etcd_namespace}' \
        --admin-username='${var.ondat_admin_username}' \
        --admin-password='${var.ondat_admin_password}' \
        --stos-cluster-namespace='${var.ondat_namespace}' \
        --stos-operator-namespace='${var.ondat_namespace}' \
        --stos-version='${var.ondat_version}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}