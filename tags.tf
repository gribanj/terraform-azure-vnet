
#============================================= TAGS

variable "default_tags_enabled" {
  description = "Option to enable or disable default tags"
  type        = bool
  default     = true
}


locals {
  tags = var.default_tags_enabled ? {
    # env   = "prod" # or can use var.env
    "owner"     = "devops"
    "terraform" = "true"
  } : {}
}


variable "extra_tags" {
  description = "Extra tags to add"
  type        = map(string)
  default     = {}
  validation {
    condition     = contains(["prod", "nonprod", "dev", "qa", "stg"], var.tags["env"])
    error_message = "ERROR: The 'env' tag value must be one of the following: 'prod', 'nonprod','qa', 'stg' or 'dev'."
  }
}
