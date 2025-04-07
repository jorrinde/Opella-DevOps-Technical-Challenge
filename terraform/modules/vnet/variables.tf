# # modules/vnet/variables.tf

variable "resource_group_name" {
  description = "El nombre del grupo de recursos donde se creará la VNet."
  type        = string
}

variable "location" {
  description = "La región de Azure donde se crearán los recursos."
  type        = string
}

variable "vnet_name" {
  description = "El nombre de la red virtual (VNet)."
  type        = string
}

variable "vnet_address_space" {
  description = "Lista de prefijos de dirección IP para la VNet (ej. [\"10.0.0.0/16\"])."
  type        = list(string)
}

variable "subnets" {
  description = "Configuraciones de subredes."
  type = map(object({
    name                                      = string						# El nombre de la subred.
    address_prefixes                          = list(string)				# Lista de prefijos CIDR para la subred.
    service_endpoints                         = optional(list(string), [])	# Lista de Service Endpoints a habilitar.
    delegate_subnet_service                   = optional(string, null)		# Nombre del delegado.
    private_endpoint_network_policies_enabled = optional(bool, true)		# Habilita/deshabilita las políticas de red para Private Endpoints en la subred.
    network_security_group_id                 = optional(string, null)		# Id del grupo de seguridad.
    route_table_id                            = optional(string, null)		# ID de la Tabla de enrutamiento
  }))
  default = {} # Por defecto, no se crean subredes si no se especifica
}

variable "dns_servers" {
  description = "Lista de servidores DNS personalizados para la VNet."
  type        = list(string)
  default     = []
}

variable "ddos_protection_plan_id" {
  description = "El ID del plan de protección DDoS a asociar con la VNet."
  type        = string
  default     = null
}

variable "tags" {
  description = "Etiquetas para aplicar a los recursos."
  type        = map(string)
  default     = {}
}