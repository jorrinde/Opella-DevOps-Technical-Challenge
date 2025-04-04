# variables.tf

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
  description = <<EOT
  Mapa de configuraciones de subredes. La clave del mapa es un identificador lógico para la subred.
  Cada objeto de subred puede incluir:
  - name: (String) El nombre de la subred en Azure.
  - address_prefixes: (List(String)) Lista de prefijos CIDR para la subred.
  - service_endpoints: (Optional(List(String))) Lista de Service Endpoints a habilitar. Por defecto [].
  - delegate_subnet_service: (Optional(String)) Nombre del servicio al que delegar la subred. Por defecto null.
  - private_endpoint_network_policies_enabled: (Optional(Bool)) Habilita/deshabilita las políticas de red para Private Endpoints en la subred. Por defecto true.
  - network_security_group_id: (Optional(String)) ID del Network Security Group a asociar. Por defecto null.
  - route_table_id: (Optional(String)) ID de la Route Table a asociar. Por defecto null.
  EOT
  type = map(object({
    name                                      = string
    address_prefixes                          = list(string)
    service_endpoints                         = optional(list(string), [])
    delegate_subnet_service                   = optional(string, null)
    private_endpoint_network_policies_enabled = optional(bool, true)
    network_security_group_id                 = optional(string, null)
    route_table_id                            = optional(string, null)
  }))
  default = {} # Por defecto, no se crean subredes si no se especifica
}

variable "dns_servers" {
  description = "Lista de servidores DNS personalizados para la VNet. Si está vacío, usa el DNS de Azure."
  type        = list(string)
  default     = []
}

variable "ddos_protection_plan_id" {
  description = "El ID del plan de protección DDoS a asociar con la VNet. Si es null, no se asocia ninguno."
  type        = string
  default     = null
}

variable "tags" {
  description = "Un mapa de etiquetas para aplicar a los recursos."
  type        = map(string)
  default     = {}
}