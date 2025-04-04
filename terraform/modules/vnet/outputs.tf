# outputs.tf

output "vnet_id" {
  description = "El ID de la red virtual creada."
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "El nombre de la red virtual creada."
  value       = azurerm_virtual_network.main.name
}

output "vnet_location" {
  description = "La región de Azure donde se creó la VNet."
  value       = azurerm_virtual_network.main.location
}

output "vnet_address_space" {
  description = "El espacio de direcciones de la red virtual."
  value       = azurerm_virtual_network.main.address_space
}

output "subnets" {
  description = "Un mapa de las subredes creadas, donde la clave es el identificador lógico proporcionado en la variable 'subnets' y el valor contiene detalles de la subred."
  value = {
    # Mapear sobre las subredes creadas para exponer sus detalles
    for k, subnet in azurerm_subnet.main : k => {
      id             = subnet.id
      name           = subnet.name
      address_prefix = subnet.address_prefixes # Nota: address_prefixes es una lista
    }
  }
  # Sensible si los prefijos de dirección se consideran sensibles
  # sensitive = true
}

# Podrías añadir outputs específicos para IDs de subred si fuera necesario
# output "subnet_ids_by_name" {
#   description = "Mapa de nombres de subred a IDs de subred."
#   value       = { for subnet in azurerm_subnet.main : subnet.name => subnet.id }
# }
