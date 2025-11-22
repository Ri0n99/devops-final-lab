terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# RESOURCE GROUP
resource "azurerm_resource_group" "rg" {
  name     = "devops-final-lab-rg"
  location = "West Europe"
}

# LOG ANALYTICS (required for AZURE KUBERNETES SERVICE)
resource "azurerm_log_analytics_workspace" "law" {
  name                = "devops-final-lab-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
# AZURE KUBERNETES SERVICE CLUSTER
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "devops-final-lab-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "devops-final-lab"

  default_node_pool {
    name       = "nodepool"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  }

  network_profile {
    network_plugin = "azure"
  }
}

# OUTPUT KUBECONFIG
output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
