
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

  # validation {
  #   condition     = can(var.extra_tags["env"]) ? contains(["prod", "nonprod", "dev", "qa", "stg"], var.extra_tags["env"]) : true
  #   error_message = "The 'env' tag value must be one of the following: 'prod', 'nonprod', 'dev', 'qa', 'stg'.\n"
  # }
}
