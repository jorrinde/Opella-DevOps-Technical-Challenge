module "network" {
  source = "./azure-network-module" # O la ruta a tu módulo (ej. Git, Terraform Registry)

  resource_group_name = "mi-grupo-recursos"
  location            = "West Europe"
  vnet_name           = "vnet-principal-prod"
  vnet_address_space  = ["10.100.0.0/16"]
  ddos_protection_plan_id = null # O "/subscriptions/.../resourceGroups/.../providers/Microsoft.Network/ddosProtectionPlans/mi-plan-ddos"

  subnets = {
    "frontend" = {
      name             = "snet-frontend"
      address_prefixes = ["10.100.1.0/24"]
      network_security_group_id = azurerm_network_security_group.frontend_nsg.id # NSG creado fuera del módulo
      service_endpoints = ["Microsoft.Storage", "Microsoft.Sql"]
    },
    "backend" = {
      name             = "snet-backend"
      address_prefixes = ["10.100.2.0/24"]
      network_security_group_id = azurerm_network_security_group.backend_nsg.id
      route_table_id            = azurerm_route_table.firewall_rt.id # RT creada fuera del módulo
    },
    "aci" = {
       name = "snet-aci-delegated"
       address_prefixes = ["10.100.3.0/25"]
       delegate_subnet_service = "Microsoft.ContainerInstance/containerGroups"
    }
    # Agrega más subredes aquí si es necesario
  }

  tags = {
    environment = "production"
    project     = "Plataforma Principal"
  }
}

# Ejemplo de NSG y RT creados fuera del módulo (en el código raíz que llama al módulo)
# resource "azurerm_network_security_group" "frontend_nsg" { ... }
# resource "azurerm_network_security_group" "backend_nsg" { ... }
# resource "azurerm_route_table" "firewall_rt" { ... }
