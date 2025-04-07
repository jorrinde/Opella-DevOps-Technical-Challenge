# modules/vnet/versions.tf

terraform {
  required_version = ">= 1.3" # Versión mínima

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # Versión específica
    }
  }
}
