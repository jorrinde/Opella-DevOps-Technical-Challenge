# Módulo Terraform para Azure Virtual Network

Este módulo aprovisiona una red virtual (VNet) de Azure y sus subredes asociadas, con opciones de configuración y características de seguridad.

## Propósito

* Crear una VNet estándar y configurable.
* Definir múltiples subredes con configuraciones específicas.
* Opcionalmente asociar Network Security Groups (NSGs) y Route Tables existentes.
* Opcionalmente habilitar Service Endpoints para servicios PaaS.
* Opcionalmente configurar delegado de subred.
* Opcionalmente asociar un plan de protección DDoS existente.

## Uso

```hcl
module "network" {
  source = "./vnet" # La ruta al módulo

  resource_group_name = "mi-grupo-recursos"
  location            = "West Europe"
  vnet_name           = "vnet-principal-prod"
  vnet_address_space  = ["10.100.0.0/16"]
  ddos_protection_plan_id = null # Ruta al recurso de Azure ddosProtectionPlan

  subnets = {
    "subnet" = {
      name             = "snet"
      address_prefixes = ["10.100.1.0/24"]
      network_security_group_id = azurerm_network_security_group.vnet_nsg.id # NSG creado previamente
      service_endpoints = ["Microsoft.ServiceBus"]
    }
  }

  tags = {
    environment = "production"
    project     = "Nombre de Proyecto"
  }
}

# Ejemplo de NSG y RT creados fuera del módulo (en el código raíz que llama al módulo)
# resource "azurerm_network_security_group" "vnet_nsg" { ... }
# resource "azurerm_route_table" "firewall_rt" { ... }

```
