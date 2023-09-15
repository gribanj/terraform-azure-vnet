resource "azurerm_virtual_network" "vnet" {
  count               = var.create ? 1 : 0
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags = merge(
    var.tags,
    {
      created   = formatdate("EEEE, DD MMM YYYY", timestamp()),
      terraform = "true"
    },
  )
  lifecycle {
    ignore_changes        = [tags]
    create_before_destroy = true
  }
}
