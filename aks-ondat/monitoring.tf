/*
=============
Azure Monitor
=============
*/
resource "random_id" "workspace" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "monitor" {
  name                       = "${var.log_analytics_workspace_name}-${random_id.workspace.dec}"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  sku                        = var.log_analytics_workspace_pricing_tier
  retention_in_days          = var.log_analytics_workspace_retention
  daily_quota_gb             = var.log_analytics_workspace_daily_quota
  tags                       = var.resource_group_tags
  internet_ingestion_enabled = true
  internet_query_enabled     = true
}

resource "azurerm_log_analytics_solution" "solution" {
  solution_name         = "ContainerInsights"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  workspace_name        = azurerm_log_analytics_workspace.monitor.name
  workspace_resource_id = azurerm_log_analytics_workspace.monitor.id
  tags                  = var.resource_group_tags
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  name                       = var.azurerm_monitor_diagnostics_name
  target_resource_id         = azurerm_kubernetes_cluster.cluster.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.monitor.id

  log {
    category = "kube-apiserver"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 7
    }
  }

  log {
    category = "kube-audit"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 7
    }
  }

  log {
    category = "kube-audit-admin"
    enabled  = false
    retention_policy {
      enabled = true
      days    = 7
    }
  }
  log {
    category = "kube-controller-manager"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 7
    }
  }

  log {
    category = "kube-scheduler"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 7
    }
  }

  log {
    category = "cluster-autoscaler"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 7
    }
  }

  log {
    category = "cloud-controller-manager"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 7
    }
  }

  log {
    category = "guard"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 7
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 7
    }
  }
}
