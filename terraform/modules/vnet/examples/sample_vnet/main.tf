module "network" {
  source = "../../"

  resource_group_name = "mi-grupo-recursos"
  location            = "West Europe"
  vnet_name           = "vnet-principal-dev"
  vnet_address_space  = ["10.100.0.0/16"]
  ddos_protection_plan_id = null # O "/subscriptions/.../resourceGroups/.../providers/Microsoft.Network/ddosProtectionPlans/plan-ddos"

  subnets = {
    "subnet" = {
      name             = "subnet"
      address_prefixes = ["10.100.1.0/24"]
      network_security_group_id = azurerm_network_security_group.subnet_nsg.id
      service_endpoints = ["Microsoft.ServiceBus"]
    }
  }

  tags = {
    environment = "development"
    project     = "AppName"
  }
}

