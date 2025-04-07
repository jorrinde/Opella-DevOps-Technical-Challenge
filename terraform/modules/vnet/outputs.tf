# modules/vnet/outputs.tf

output "vnet_id" {
  description = "El ID de la red virtual creada."
  value       = vnet.main.id
}

output "vnet_name" {
  description = "El nombre de la red virtual creada."
  value       = vnet.main.name
}

output "vnet_location" {
  description = "La región de Azure donde se creó la VNet."
  value       = vnet.main.location
}

output "vnet_address_space" {
  description = "El espacio de direcciones de la red virtual."
  value       = vnet.main.address_space
}

output "subnets" {
  description = "Subredes creadas, donde la clave es el identificador lógico proporcionado en la variable 'subnets' y el valor contiene los detalles de la subred."
  value = {
    # Mapear sobre las subredes creadas para exponer sus detalles
    for k, subnet in azure_subnet.main : k => {
      id             = subnet.id
      name           = subnet.name
      address_prefix = subnet.address_prefixes
    }
  }
  # Los prefijos de dirección son sensibles
  # sensitive = true
}

# Podrías añadir outputs específicos para IDs de subred si fuera necesario
# output "subnet_ids_by_name" {
#   description = "Nombres de subred a IDs de subred."
#   value       = { for subnet in azure_subnet.main : subnet.name => subnet.id }
# }
