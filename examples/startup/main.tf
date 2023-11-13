#========================================================= LOCAL VARIABLES

locals {
  env = "prod"
}

#========================================================= RESOURCE GROUP

module "rg" {
  source   = "gribanj/rg/azure"
  create   = var.create
  name     = var.name
  location = var.location
  tags     = merge(local.default_tags, var.extra_tags)

  # Adding custom tags to the resource

  # tags = merge(
  #   var.tags,
  #   {
  #     "env"   = local.env,
  #     "owner" = "devops"
  #   },
  # )

}

#========================================================= VIRTUAL NETWORK

module "vnet" {
  source              = "gribanj/vnet/azure"
  create              = true
  version             = "v0.1.0"
  name                = "vnet-xxxxxx-prod"
  resource_group_name = module.rg.rg_output[0].name
  location            = module.rg.rg_output[0].location
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.1", "10.0.0.2"] # Can be empty if not used

}
