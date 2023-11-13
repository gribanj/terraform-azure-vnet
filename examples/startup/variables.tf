variable "tags" {
  type        = map(string)
  description = "A map of tags to add to the resource"
  default = {
    "createdby" = "griban"
    "workload"  = "v3"
  }
}

variable "create" {
  description = "Boolean flag to control whether a new resource should be created"
  type        = bool
  default     = false
}

variable "name" {
  description = "The name of the resource"
  type        = string
  default     = "rg-xxxxx-prod"
}

variable "location" {
  description = "The location of the resource"
  type        = string
  default     = "westus3"
}
