# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
provider "azurerm" {
  features {}
  # ARM_TENANT_ID
  # ARM_SUBSCRIPTION_ID
  # ARM_CLIENT_ID
  # ARM_CLIENT_SECRET
}

# Configurations
locals {
  name           = var.name
  location       = var.region
  resource_group = var.resource_group
}

# Azure Resources

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "aks" {
  name                = local.name
  location            = local.location
  resource_group_name = local.resource_group

  domain_name_label = local.name
  allocation_method = "Static"
  sku               = "Standard"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting
resource "azurerm_monitor_diagnostic_setting" "ip" {
  name               = local.name
  target_resource_id = azurerm_public_ip.aks.id

  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "DDoSProtectionNotifications"
  }

  log {
    category = "DDoSMitigationFlowLogs"
  }

  log {
    category = "DDoSMitigationReports"
  }
}

# https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html
resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.name
  location            = local.location
  resource_group_name = local.resource_group

  dns_prefix = local.name
  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_B2ms"
    type            = "VirtualMachineScaleSets"
    os_disk_size_gb = 30
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  service_principal {
    client_id     = var.aks_client_id
    client_secret = var.aks_client_secret
  }

  role_based_access_control {
    enabled = false
  }

  addon_profile {
    kube_dashboard {
      enabled = false
    }

    oms_agent {
      enabled                    = var.aks_oms_agent_enabled
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting
resource "azurerm_monitor_diagnostic_setting" "aks" {
  name               = local.name
  target_resource_id = azurerm_kubernetes_cluster.aks.id

  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "kube-apiserver"
  }

  log {
    category = "kube-audit"
  }

  log {
    category = "kube-audit-admin"
  }

  log {
    category = "kube-controller-manager"
  }

  log {
    category = "kube-scheduler"
  }

  log {
    category = "cluster-autoscaler"
  }

  log {
    category = "guard"
  }
}
