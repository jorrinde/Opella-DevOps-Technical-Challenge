# environments/dev/outputs.tf

output "resource_group_name" {
  description = "Nombre del grupo de recursos donde se desplegaron los recursos."
  value       = module.vnet.resource_group_name
}

output "vnet_id" {
  description = "ID de la VNet creada."
  value       = module.vnet.vnet_id
}

output "web_subnet_id" {
  description = "ID de la subred 'web' creada."
  value       = module.vnet.subnet_ids["web"] # Si el módulo VNET devuelve un mapa de subnets
}

output "nsg_id" {
  description = "ID del Network Security Group asociado a la subred/NIC."
  value       = module.nsg.nsg_id
}
