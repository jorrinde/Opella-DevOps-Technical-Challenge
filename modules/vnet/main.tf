# main.tf

resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  dns_servers         = length(var.dns_servers) > 0 ? var.dns_servers : null 

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan_id != null ? [1] : []
    content {
      id     = var.ddos_protection_plan_id
      enable = true 
    }
  }

  tags = var.tags
}

resource "azurerm_subnet" "main" {
  # Crear una subred por cada entrada en el mapa var.subnets
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = lookup(each.value, "service_endpoints", []) 

  # Políticas de Private Endpoint
  private_endpoint_network_policies_enabled = lookup(each.value, "private_endpoint_network_policies_enabled", true)

  # Delegación de subred
  dynamic "delegation" {
    for_each = lookup(each.value, "delegate_subnet_service", null) != null ? [lookup(each.value, "delegate_subnet_service")] : []
    content {
      name = format("%s-delegation", delegation.value) 
      service_delegation {
        name    = delegation.value
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"] 
      }
    }
  }

  # Asociaciones condicionales directamente en la subred
  network_security_group_id = lookup(each.value, "network_security_group_id", null)
  route_table_id            = lookup(each.value, "route_table_id", null)
}
