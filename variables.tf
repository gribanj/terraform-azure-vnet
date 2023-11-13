#============================================= VNET

variable "name" {
  description = "The name of the virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be created."
  type        = string
}

variable "location" {
  description = "The location (Azure region) where the resource group and virtual network will be created."
  type        = string
  default     = "westus3"
}

variable "address_space" {
  description = "The address space that is used the by the virtual network. You should input it in CIDR notation."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "dns_servers" {
  description = "List of IP addresses of DNS servers for the virtual network."
  type        = list(string)
  default     = []
}

#============================================= LOGIC

variable "create" {
  description = "Boolean flag to control whether a new resource should be created"
  type        = bool
  default     = false
}

# #============================================= TAGS

# variable "tags" {
#   type        = map(string)
#   description = "A map of tags to add to the resource"
#   default = {
#     "owner"     = "devops"
#     "terraform" = "true"
#     "env"       = "prod"
#   }
#   validation {
#     condition     = contains(["prod", "nonprod", "dev", "qa", "stg"], var.tags["env"])
#     error_message = "ERROR: The 'env' tag value must be one of the following: 'prod', 'nonprod','qa', 'stg' or 'dev'."
#   }
# }

