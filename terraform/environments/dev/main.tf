# environments/dev/main.tf
locals {
  common_tags = {
    Environment     = var.environment
    Region          = var.location
    ApplicationName = "AppName"
    ManagedBy       = "Terraform"
  }
}

module "vnet" {
  source = "../../modules/vnet"
  tags = local.common_tags
}

module "nsg" {
  source = "../../modules/nsg"
  tags = local.common_tags
}

